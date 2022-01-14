import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muaho/common/extensions/ui/inject.dart';
import 'package:muaho/common/localization/app_localization.dart';
import 'package:muaho/generated/locale_keys.g.dart';
import 'package:muaho/features/components/app_bar_component.dart';

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
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                child: Text(
                  LocaleKeys.chatWithSupport_userName.translate(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.white),
                ),
                radius: 16,
                backgroundColor: Theme.of(context).primaryColorLight,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                child: Text(
                  LocaleKeys.chatWithSupport_csName.translate(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.white),
                ),
                radius: 16,
                backgroundColor: Colors.green,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.end,
                ),
              ),
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
      create: (context) => inject()..add(InitEvent()),
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

  Widget _buildScaffold(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarComponent.titleOnly(
            title: LocaleKeys.chatWithSupport_titleScreen.translate(),
          ),
          body: Container(
            child: Column(
              children: [
                Flexible(
                  child: _buildBody(),
                ),
                const Divider(height: 1.0),
                Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).backgroundColor),
                  child: _buildTextComposer(),
                ),
              ],
            ),
            decoration: null,
          ),
        ),
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
            child: Text(
                LocaleKeys.chatWithSupport_lostConnectErrorMsg.translate()),
          );
        } else {
          return Center(
            child: Text(LocaleKeys.chatWithSupport_netWorkErrorMsg.translate()),
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
