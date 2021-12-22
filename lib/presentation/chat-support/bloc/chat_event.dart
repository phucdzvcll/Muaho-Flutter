part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class InitEvent extends ChatEvent {}

class OpenTicketEvent extends ChatEvent {
  final String displayName;

  OpenTicketEvent({required this.displayName});

}

class CloseTicketEvent extends ChatEvent {}

class SendChatMsgEvent extends ChatEvent {
  final String msg;

  SendChatMsgEvent({required this.msg});
}
