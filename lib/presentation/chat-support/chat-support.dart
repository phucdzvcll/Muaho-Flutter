import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/main.dart';

import 'bloc/chat_bloc.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    required this.text,
    required this.isMine,
    required this.animationController,
    Key? key,
  }) : super(key: key);
  final String text;
  final bool isMine;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: ChatMessageNoAnimation(
        text: text,
        isMine: isMine,
      ),
    );
  }
}

class ChatMessageNoAnimation extends StatelessWidget {
  const ChatMessageNoAnimation({
    Key? key,
    required this.text,
    required this.isMine,
  }) : super(key: key);

  final String text;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    if (isMine) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.end,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(child: Text("I")),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text("CS")),
            ),
            Expanded(
              child: Text(text),
            ),
          ],
        ),
      );
    }
  }
}

class ChatScreen extends StatefulWidget {
  static const routeName = '/support-chat';

  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessageNoAnimation> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  void _handleSubmitted(String text, BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(SendChatMsgEvent(msg: text));
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (context) =>
          getIt()..add(InitEvent()),
      child: BlocListener<ChatBloc, ChatState>(
        listenWhen: (pre, current) {
          return current is InsertChatMsgState;
        },
        listener: (context, state) {
          if (state is InsertChatMsgState) {
            var message = _buildChatMessage(state.msg);
            setState(() {
              _messages.insert(0, message);
            });
            _focusNode.requestFocus();
          }
        },
        child: _buildScaffold(context),
      ),
    );
  }

  ChatMessageNoAnimation _buildChatMessage(MessageModel msg) {
    return ChatMessageNoAnimation(
      text: msg.msg,
      isMine: msg.isMyMsg,
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with supporters'),
        elevation: 4.0,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: _buildBody(),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: null,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (pre, current) {
        return !(current is InsertChatMsgState);
      },
      builder: (context, state) {
        if (state is ChatMsgListState) {
          _messages.clear();
          state.msgs.forEach((msg) {
            ChatMessageNoAnimation chatMessage = _buildChatMessage(msg);
            _messages.add(chatMessage);
          });

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, index) {
              var message = _messages[index];
              return message;
            },
            itemCount: _messages.length,
          );
        } else if (state is ChatLostConnectionState) {
          return Center(
            child: Text("Lost connection!"),
          );
        } else {
          return Center(
            child: Text("Let's connect & chat with supporters."),
          );
        }
      },
    );
  }

  Widget _buildTextComposer() {
    return Builder(builder: (context) {
      return IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _textController,
                  onChanged: (text) {
                    setState(() {
                      _isComposing = text.isNotEmpty;
                    });
                  },
                  onSubmitted: _isComposing
                      ? (text) {
                          _handleSubmitted(text, context);
                        }
                      : null,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Send a message'),
                  focusNode: _focusNode,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text, context)
                      : null,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
