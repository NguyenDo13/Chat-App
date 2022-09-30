import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Dimensions.width14,
          Dimensions.height14,
          Dimensions.width14,
          0,
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: demoMessages.length,
          itemBuilder: (context, index) {
            final messages = demoMessages[index].content!;
            return Padding(
              padding: EdgeInsets.only(bottom: Dimensions.height14),
              child: Row(
                mainAxisAlignment: demoMessages[index].isSender
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (!demoMessages[index].isSender) ...[
                    StateAvatar(
                      avatar: 'assets/avatars/user3.jpg',
                      isStatus: true,
                      radius: Dimensions.double40,
                    ),
                    SizedBox(
                      width: Dimensions.width12 / 2,
                    ),
                  ],
                  Column(
                    crossAxisAlignment: demoMessages[index].isSender
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: messages.map((message) {
                      return _chatItem(index, message);
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _chatItem(int index, String message) {
    return Container(
      constraints: BoxConstraints(maxWidth: Dimensions.width250),
      margin: EdgeInsets.only(top: Dimensions.height2),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width9,
        vertical: Dimensions.height6,
      ),
      decoration: BoxDecoration(
        color: demoMessages[index].isSender ? blue : darkGreyDarkMode,
        borderRadius: BorderRadius.circular(Dimensions.double30 / 3),
      ),
      child: Text(
        message,
        overflow: TextOverflow.ellipsis,
        maxLines: maxValueInteger,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
