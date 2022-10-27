import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final bool theme;
  final bool isSender;
  final bool isLastItem;
  const MessageItem({
    super.key,
    required this.message,
    required this.theme,
    required this.isSender,
    required this.isLastItem,
  });

  @override
  Widget build(BuildContext context) {
    final colorBG = theme ? darkGreyDarkMode : lightGreyLightMode;
    final colorSenderBG = theme ? darkBlue : lightBlue;
    final radius15 = Radius.circular(Dimensions.double12);

    return Container(
      constraints: BoxConstraints(maxWidth: Dimensions.screenWidth * 4 / 5),
      margin: EdgeInsets.only(top: Dimensions.height10 / 2),
      padding: EdgeInsets.fromLTRB(
        Dimensions.height12,
        Dimensions.height12,
        Dimensions.height12,
        Dimensions.height12,
      ),
      decoration: BoxDecoration(
        color: isSender ? colorSenderBG : colorBG,
        borderRadius: BorderRadius.only(
          bottomLeft: isSender ? radius15 : const Radius.circular(0),
          bottomRight: isSender ? const Radius.circular(0) : radius15,
          topLeft: radius15,
          topRight: radius15,
        ),
        boxShadow: [
          BoxShadow(
            color: isSender ? Colors.black45 : Colors.black12,
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: isSender
          ? Text(
              message.content,
              overflow: TextOverflow.ellipsis,
              maxLines: maxValueInteger,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white),
            )
          : Text(
              message.content,
              overflow: TextOverflow.ellipsis,
              maxLines: maxValueInteger,
              style: Theme.of(context).textTheme.displaySmall,
            ),
    );
  }
}
