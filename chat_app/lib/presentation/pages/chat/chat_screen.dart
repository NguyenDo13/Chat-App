import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/pages/chat/components/app_bar.dart';
import 'package:chat_app/presentation/pages/chat/components/chat_input_field.dart';
import 'package:chat_app/presentation/pages/chat/components/message_view.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controllerChat = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
      ),
      body: Column(
        children: [
          const MessageView(),
          ChatInputField(
            controllerChat: _controllerChat,
          ),
        ],
      ),
    );
  }
}
