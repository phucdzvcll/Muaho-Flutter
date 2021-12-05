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
      _handleEvent(event);
    });
  }

  void _handleEvent(ChatEvent event) {
    log('_handleEvent chat bloc');
    if (event is InitEvent) {
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
    }
  }
}
