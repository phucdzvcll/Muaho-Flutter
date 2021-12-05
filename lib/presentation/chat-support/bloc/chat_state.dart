part of 'chat_bloc.dart';

@immutable
class MessageModel {
  final bool isMyMsg;
  final String msg;

  MessageModel({required this.isMyMsg, required this.msg});
}

@immutable
class ChatState{}

@immutable
class ChatInitState extends ChatState {
  
}

@immutable
class ChatMsgState {
  final bool isOpen;
  final List<MessageModel> msgs;

  ChatMsgState({required this.isOpen, required this.msgs});
}
