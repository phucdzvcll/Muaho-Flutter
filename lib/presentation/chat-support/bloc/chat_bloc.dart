import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/data/remote/chat/list_msg.dart';
import 'package:muaho/data/remote/chat/msg_list.dart';
import 'package:muaho/data/remote/chat/news.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'chat_event.dart';
part 'chat_state.dart';

class _ChatNeedCreateTicketEvent extends ChatEvent {}

class _ChatLostConnectionEvent extends ChatEvent {}

class _ChatMsgListEvent extends ChatEvent {}

class _OpenChatSessionEvent extends ChatEvent {
  final int userId;

  _OpenChatSessionEvent({required this.userId});
}

class _InsertChatMsgEvent extends ChatEvent {
  final MessageModel msg;

  _InsertChatMsgEvent({required this.msg});
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  IO.Socket? _socket;
  List<MessageModel> _chatMss = [];
  Timer? _timerPingSocket;
  int _chatUserId = 0;
  final UserStore userStore;

  ChatBloc({required this.userStore}) : super(ChatInitState()) {
    on<InitEvent>((event, emit) {
      _handleInitEvent(emit);
    });

    on<OpenTicketEvent>((event, emit) {
      _handleOpenTicketEvent(emit, event.displayName);
    });

    on<_OpenChatSessionEvent>((event, emit) {
      _chatUserId = event.userId;
    });

    on<SendChatMsgEvent>((event, emit) {
      _handleSendChatEvent(emit, event.msg);
    });

    on<_ChatLostConnectionEvent>((event, emit) {
      _chatUserId = 0;
      emit(ChatLostConnectionState());
    });

    on<_ChatMsgListEvent>((event, emit) {
      emit(ChatMsgListState(msgs: _chatMss));
    });

    on<_InsertChatMsgEvent>((event, emit) {
      emit(InsertChatMsgState(msg: event.msg));
    });

    on<_ChatNeedCreateTicketEvent>((event, emit) {
      emit(ChatNeedCreateTicketState());
    });
  }
  @override
  Future<void> close() {
    _timerPingSocket?.cancel();
    _socket?.close();
    return super.close();
  }

  void _handleInitEvent(Emitter<ChatState> emit) {
    String? token = userStore.getToken();
    _socket = IO.io(
        'http://103.221.220.249:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']).setAuth({'token': token}).build());

    _socket = _socket?.connect();
    _timerPingSocket?.cancel();

    _socket?.onConnect((_) async {
      log('connect');
      //add(_ChatNeedCreateTicketEvent());
      _socket
          ?.emit("open_chat_session", {"name": await userStore.getUserName()});

      _timerPingSocket?.cancel();
      _timerPingSocket = Timer.periodic(Duration(seconds: 5000), (timer) {
        _socket?.emit("ping");
      });
    });

    _socket?.onError((data) {
      log('onError $data');
      add(_ChatLostConnectionEvent());
    });

    _socket?.onDisconnect((data) {
      log('onDisconnect $data');
      add(_ChatLostConnectionEvent());
      _timerPingSocket?.cancel();
    });

    _socket?.on('open_chat_session_success', (data) {
      log("open_chat_session_success: $data");

      add(_OpenChatSessionEvent(userId: data["userId"] ?? 0));
    });

    _socket?.on('chats_history', (data) {
      log("chats_history: $data");
      _chatMss.clear();
      ListMsg listMsg = ListMsg.fromJson(data);
      listMsg.msgList?.forEach((msg) {
        _chatMss.insert(0, _mapChat(msg));
      });

      add(_ChatMsgListEvent());
    });

    _socket?.on('new_chats', (data) {
      log("new_chats: $data");
      if (data != null) {
        data.forEach((v) {
          var newsChat = NewsChat.fromJson(v);
          var msg = _mapNewsChat(newsChat);
          _chatMss.insert(0, msg);
          //add(_InsertChatMsgEvent(msg: msg));
        });

        add(_ChatMsgListEvent());
      }
    });
  }

  void _handleSendChatEvent(Emitter<ChatState> emit, String msg) {
    log("_handleSendChatEvent: $msg");
    _socket?.emit("chat", {"msg": msg});
  }

  void _handleOpenTicketEvent(Emitter<ChatState> emit, String displayName) {
    log("_handleOpenTicketEvent: $displayName");
    _socket?.emit("open_ticket", {"name": displayName});
  }

  MessageModel _mapNewsChat(NewsChat newsChat) {
    return MessageModel(
        isMyMsg: newsChat.senderId == _chatUserId, msg: newsChat.msg ?? '');
  }

  MessageModel _mapChat(MsgList msg) {
    return MessageModel(
        isMyMsg: msg.senderId == _chatUserId, msg: msg.msg ?? '');
  }
}
