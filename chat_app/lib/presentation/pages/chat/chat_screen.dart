import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/pages/chat/components/chat_input_field.dart';
import 'package:chat_app/presentation/pages/chat/components/message_view.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controllerChat = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const MessageView(),
          ChatInputField(controllerChat: _controllerChat),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: Dimensions.height72,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StateAvatar(
            avatar: 'assets/avatars/user1.jpg',
            isStatus: true,
            radius: Dimensions.double40,
          ),
          SizedBox(
            width: Dimensions.width12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nguyễn Dộ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Đang hoạt động',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.phone,
            size: Dimensions.double12 * 2,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.videocam_rounded,
            size: Dimensions.double30,
          ),
        ),
        SizedBox(
          width: Dimensions.width12,
        ),
      ],
    );
  }
}
