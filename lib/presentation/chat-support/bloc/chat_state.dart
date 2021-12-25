part of 'chat_bloc.dart';

@immutable
class MessageModel {
  final bool isMyMsg;
  final String msg;

  MessageModel({required this.isMyMsg, required this.msg});
}

@immutable
class ChatState {}

@immutable
class ChatInitState extends ChatState {}

@immutable
class ChatNeedCreateTicketState extends ChatState {}

@immutable
class ChatLostConnectionState extends ChatState {}

@immutable
class ChatMsgListState extends ChatState {
  final List<MessageModel> msgs;

  ChatMsgListState({required this.msgs});
}

@immutable
class InsertChatMsgState extends ChatState {
  final MessageModel msg;

  InsertChatMsgState({required this.msg});
}
