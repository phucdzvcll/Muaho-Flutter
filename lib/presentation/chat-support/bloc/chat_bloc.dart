import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/TokenStore.dart';
import 'package:muaho/data/remote/chat/list_msg.dart';
import 'package:muaho/data/remote/chat/msg_list.dart';
import 'package:muaho/data/remote/chat/news.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'chat_event.dart';
part 'chat_state.dart';

class _ChatNeedCreateTicketEvent extends ChatEvent {}
class _ChatLostConnectionEvent extends ChatEvent {}
class _ChatMsgListEvent extends ChatEvent {}
class _InsertChatMsgEvent extends ChatEvent {
  final MessageModel msg;

  _InsertChatMsgEvent({required this.msg});

}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  IO.Socket? _socket;
  List<MessageModel> _chatMsgs = [];
  Timer? _timerPingSocket;

  ChatBloc() : super(ChatInitState()) {
    on<InitEvent>((event, emit) {
      _handleInitEvent(emit);
    });

    on<OpenTicketEvent>((event, emit) {
      _handleOpenTicketEvent(emit, event.displayName);
    });

    on<SendChatMsgEvent>((event, emit) {
      _handleSendChatEvent(emit, event.msg);
    });

    on<_ChatLostConnectionEvent>((event, emit) {
      emit(ChatLostConnectionState());
    });

    on<_ChatMsgListEvent>((event, emit) {
      emit(ChatMsgListState(msgs: _chatMsgs));
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
    String token = GetIt.instance.get<TokenStore>().token;
    _socket = IO.io(
        'http://103.221.220.249:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']).setAuth({'token': token}).build());

    _socket = _socket?.connect();
    _timerPingSocket?.cancel();

    _socket?.onConnect((_) {
      log('connect');
      //add(_ChatNeedCreateTicketEvent());
      _socket?.emit("open_ticket", {"name": "Guest"});

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
    });

    _socket?.on('old_news', (data) {
      log("old_news: $data");
      _chatMsgs.clear();
      ListMsg listMsg = ListMsg.fromJson(data);
      listMsg.msgList?.forEach((msg) {
        _chatMsgs.add(_mapChat(msg));
      });

     add(_ChatMsgListEvent());
    });
    _socket?.on('news', (data) {
      log("news: $data");
      if (data != null) {
        data.forEach((v) {
          var newsChat = NewsChat.fromJson(v);
          var msg = _mapNewsChat(newsChat);
          _chatMsgs.add(msg);
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
    return MessageModel(isMyMsg: false, msg: newsChat.msg ?? '');
  }

  MessageModel _mapChat(MsgList msg) {
    return MessageModel(isMyMsg: false, msg: msg.msg ?? '');
  }
}
