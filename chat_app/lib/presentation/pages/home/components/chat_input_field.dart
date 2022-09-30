import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController controllerChat;
  const ChatInputField({super.key, required this.controllerChat});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width14,
        vertical: Dimensions.height10,
      ),
      decoration: BoxDecoration(
        color: blackDarkMode,
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(
              Icons.camera_alt,
              color: blue,
            ),
            SizedBox(
              width: Dimensions.width14,
            ),
            const Icon(
              CupertinoIcons.photo,
              color: blue,
            ),
            SizedBox(
              width: Dimensions.width14,
            ),
            const Icon(
              Icons.mic,
              color: blue,
            ),
            SizedBox(
              width: Dimensions.width14,
            ),
            Expanded(
              child: Container(
                height: Dimensions.height48,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.double40),
                  color: darkGreyDarkMode,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.controllerChat,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nhắn tin",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width14,
                    ),
                    const Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: blue,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.width14,
            ),
            // Text(
            //   '😂',
            //   style: TextStyle(fontSize: Dimensions.double24),
            // ),
            const Icon(
              CupertinoIcons.heart_fill,
              color: red,
            ),
          ],
        ),
      ),
    );
  }
}
