part of 'chat_bloc.dart';

@immutable
class MessageModel extends Equatable {
  final bool isMyMsg;
  final String msg;

  MessageModel({required this.isMyMsg, required this.msg});

  @override
  List<Object?> get props => [isMyMsg, msg];
}

@immutable
abstract class ChatState extends Equatable {

}

@immutable
class ChatInitState extends ChatState {
  @override
  List<Object?> get props => [];
}

@immutable
class ChatNeedCreateTicketState extends ChatState {
  @override
  List<Object?> get props => [];
}

@immutable
class ChatLostConnectionState extends ChatState {
  @override
  List<Object?> get props => [];
}

@immutable
class ChatMsgListState extends ChatState {
  final List<MessageModel> msgs;

  ChatMsgListState({required this.msgs});

  @override
  List<Object?> get props => [msgs];
}

@immutable
class InsertChatMsgState extends ChatState {
  final MessageModel msg;

  InsertChatMsgState({required this.msg});

  @override
  List<Object?> get props => [msg];
}
