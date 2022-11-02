import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  final Message message;
  final bool theme;
  final bool isSender;
  const MessageItem({
    super.key,
    required this.message,
    required this.theme,
    required this.isSender,
  });

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  late bool _isMessageInfo;
  @override
  void initState() {
    _isMessageInfo = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // UI
    final colorBG = widget.theme ? darkGreyDarkMode : lightGreyLightMode;
    final colorSenderBG = widget.theme ? darkBlue : lightBlue;
    final radius15 = Radius.circular(Dimensions.double12);

    return Column(
      crossAxisAlignment:
          widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isMessageInfo = !_isMessageInfo;
            });
          },
          onLongPress: () {
            _bottomActionMessage(context);
          },
          child: widget.message.type == 'image'
              ? _imageMessage()
              : _textMessage(colorSenderBG, colorBG, radius15, context),
        ),
        if (_isMessageInfo) ...[
          SizedBox(height: Dimensions.height2),
          _infoMsgWidget(context),
        ],
        if (widget.message.state == 'failed') ...[
          SizedBox(height: Dimensions.height4),
          _sendMsgFailedWidget(context),
        ],
      ],
    );
  }

  Row _sendMsgFailedWidget(BuildContext context) {
    return Row(
      children: [
        Text(
          "Không gửi được",
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Colors.red),
        ),
        SizedBox(width: Dimensions.height4),
        const Icon(
          Icons.error,
          size: 16,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _infoMsgWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Đã xem',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        SizedBox(width: Dimensions.width14),
        Text(
          formatTime(widget.message.time),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Widget _imageMessage() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: Dimensions.screenWidth * 4 / 5,
      ),
      margin: EdgeInsets.only(top: Dimensions.height10 / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.double12),
        boxShadow: [
          BoxShadow(
            color: widget.isSender ? Colors.black45 : Colors.black12,
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.double16 / 2),
        child: CachedNetworkImage(
          imageUrl: "https://appsocketonline2.herokuapp.com${widget.message.content}",
        ),
      ),
    );
  }

  Widget _textMessage(
    Color colorSenderBG,
    Color? colorBG,
    Radius radius15,
    BuildContext context,
  ) {
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
          color: widget.isSender ? colorSenderBG : colorBG,
          borderRadius: BorderRadius.only(
            bottomLeft: widget.isSender ? radius15 : const Radius.circular(0),
            bottomRight: widget.isSender ? const Radius.circular(0) : radius15,
            topLeft: radius15,
            topRight: radius15,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isSender ? Colors.black45 : Colors.black12,
              offset: const Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Text(
          widget.message.content,
          overflow: TextOverflow.ellipsis,
          maxLines: maxValueInteger,
          style: widget.isSender
              ? Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white)
              : Theme.of(context).textTheme.displaySmall,
        ));
  }

  void _bottomActionMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 82,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _actionMessage(
              context: context,
              icon: Icons.highlight_remove_rounded,
              action: () {
                ScaffoldMessenger.of(context).clearSnackBars();
              },
              title: "Xóa",
            ),
            _actionMessage(
              context: context,
              icon: Icons.next_plan,
              title: "Chuyển tiếp",
            ),
            _actionMessage(
              context: context,
              icon: Icons.reply_outlined,
              title: "Trả lời",
            ),
            _actionMessage(
              context: context,
              icon: Icons.menu,
              title: "Xem thêm",
            ),
          ],
        )),
      ),
      duration: const Duration(seconds: maxValueInteger),
    ));
  }

  Column _actionMessage({
    required BuildContext context,
    required IconData icon,
    Function()? action,
    required String title,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: action,
          icon: Icon(icon),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}
