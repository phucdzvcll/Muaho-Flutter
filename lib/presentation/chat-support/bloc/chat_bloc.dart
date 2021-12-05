import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/TokenStore.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  IO.Socket? _socket;

  ChatBloc() : super(ChatInitState()) {
    on<ChatEvent>((event, emit) {
      _handleEvent(event, emit);
    });
  }

  void _handleEvent(ChatEvent event, Emitter<ChatState> emit) {
    log('_handleEvent chat bloc');
    if (event is InitEvent) {
      _handleInitEvent(emit);
    } else if (event is SendChatMsgEvent) {
      _handleSendChatEvent(emit, event.msg);
    }
  }

  void _handleInitEvent(Emitter<ChatState> emit) {
    String token = GetIt.instance.get<TokenStore>().token;
    _socket = IO.io(
        'http://192.168.0.103:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']).setAuth({'token': token}).build());

    _socket?.onConnect((_) {
      log('connect');
    });

    _socket?.onError((data) {
      log('onError $data');
    });

    _socket?.onDisconnect((data) {
      log('onDisconnect $data');
    });

    _socket?.on('old_news', (data) => log("old_news: $data"));
    _socket?.on('news', (data) => log("news: $data"));
  }

  void _handleSendChatEvent(Emitter<ChatState> emit, String msg) {
    log("_handleSendChatEvent: $msg");
    _socket?.emit("chat", {"msg": msg});
  }
}
