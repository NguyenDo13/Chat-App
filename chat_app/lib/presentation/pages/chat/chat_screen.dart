import 'package:chat_app/presentation/pages/chat/components/app_bar.dart';
import 'package:chat_app/presentation/pages/chat/components/chat_input_field.dart';
import 'package:chat_app/presentation/pages/chat/components/message_view.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String idRoom;
  final String friendID;
  const ChatScreen({
    super.key,
    required this.idRoom,
    required this.friendID,
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
            idRoom: widget.idRoom,
            idFriend: widget.friendID,
          ),
        ],
      ),
    );
  }
}
