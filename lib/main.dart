import 'package:flutter/material.dart';

import 'chat_message.dart';

void main() {
  runApp(
    const FriendlyChatApp(),
  );
}

class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FriendlyChat',
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final FocusNode _focusNode = FocusNode();

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text));
    });
    _focusNode.requestFocus();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                focusNode: _focusNode,
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemBuilder: (_, index) => _messages[index],
      itemCount: _messages.length,
      padding: const EdgeInsets.all(8),
      reverse: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FriendlyChat'),
      ),
      body: Column(
        children: [
          Flexible(child: Scrollbar(child: _buildMessageList())),
          const Divider(
            height: 1,
          ),
          Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer()),
        ],
      ),
    );
  }
}
