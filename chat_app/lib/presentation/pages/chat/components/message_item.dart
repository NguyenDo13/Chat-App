import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/presentation/pages/chat/components/cannot_load_img.dart';
import 'package:chat_app/presentation/pages/chat/components/image_message.dart';
import 'package:chat_app/presentation/pages/chat/components/video_message.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:flutter/material.dart';

import 'loading_msg.dart';

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
    final crossAxisAlign =
        widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    var hieght2 = SizedBox(height: Dimensions.height2);
    var height4 = SizedBox(height: Dimensions.height4);
    return Column(
      crossAxisAlignment: crossAxisAlign,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isMessageInfo = !_isMessageInfo),
          onLongPress: () => ScaffoldMessenger.of(context).showSnackBar(
            _bottomActionMsg(context),
          ),
          child: _message(colorSenderBG, colorBG, radius15),
        ),
        if (_isMessageInfo) ...[
          hieght2,
          _infoMsgWidget(context),
        ],
        if (widget.message.state == 'failed') ...[
          height4,
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

  Widget _message(colorSenderBG, colorBG, radius15) {
    switch (widget.message.type) {
      case 'image':
        return GestureDetector(
          onTap: () {},
          child: _imagesMessageWidget(widget.message.content),
        );
      case 'video':
        return _videosMessageWidget(widget.message.content);
      default:
        return _textMessageWidget(colorSenderBG, colorBG, radius15);
    }
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

  Widget _videosMessageWidget(List<dynamic> urlList) {
    return Column(
      crossAxisAlignment:
          widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: urlList.map((url) {
        return VideoMessage(
          url: url,
          isSender: widget.isSender,
          theme: widget.theme,
        );
      }).toList(),
    );
  }

  Widget _imagesMessageWidget(List<dynamic> paths) {
    return Column(
      crossAxisAlignment:
          widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: paths.map((path) {
        return ImageMessage(
          isSender: widget.isSender,
          theme: widget.theme,
          path: path,
        );
      }).toList(),
    );
  }

  Widget _textMessageWidget(colorSenderBG, colorBG, radius15) {
    return Container(
      constraints: BoxConstraints(maxWidth: Dimensions.screenWidth * 4 / 5),
      margin: EdgeInsets.only(top: Dimensions.height10 / 2),
      padding: EdgeInsets.all(Dimensions.height12),
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
      ),
    );
  }

  SnackBar _bottomActionMsg(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 82,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _actionMessage(
              icon: Icons.highlight_remove_rounded,
              action: () {
                ScaffoldMessenger.of(context).clearSnackBars();
              },
              title: "Xóa",
            ),
            _actionMessage(
              icon: Icons.next_plan,
              title: "Chuyển tiếp",
            ),
            _actionMessage(
              icon: Icons.reply_outlined,
              title: "Trả lời",
            ),
            _actionMessage(
              icon: Icons.menu,
              title: "Xem thêm",
            ),
          ],
        )),
      ),
      duration: const Duration(seconds: maxValueInteger),
    );
  }

  Widget _actionMessage(
      {required IconData icon, Function()? action, required String title}) {
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
