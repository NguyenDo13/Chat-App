import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/presentation/pages/chat/components/message_item.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClusterMessages extends StatefulWidget {
  final String avatarFriend;
  final bool theme;
  final bool isSender;
  final List<dynamic> messages;
  final bool isLastCluster;
  const ClusterMessages({
    super.key,
    required this.theme,
    required this.isSender,
    required this.messages,
    required this.avatarFriend,
    required this.isLastCluster,
  });

  @override
  State<ClusterMessages> createState() => _ClusterMessagesState();
}

class _ClusterMessagesState extends State<ClusterMessages> {
  late bool _stateLastMsg;
  late bool _islastItem;
  late int _currentIndex;

  @override
  void initState() {
    _stateLastMsg = false;
    _islastItem = false;
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timeMessageItem = Message.fromJson(widget.messages.last).time;
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.height10,
        bottom: Dimensions.height10,
      ),
      child: Row(
        mainAxisAlignment:
            widget.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: widget.isSender
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: widget.isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: widget.messages.map((item) {
                  if (widget.isLastCluster) {
                    setState(() {
                      _currentIndex++;
                    });
                    _changeStateLastMsg();
                  }
                  final msg = Message.fromJson(item);
                  return MessageItem(
                    message: msg,
                    theme: widget.theme,
                    isSender: widget.isSender,
                    isLastItem: _islastItem,
                  );
                }).toList(),
              ),
              SizedBox(
                height: Dimensions.height4,
              ),
              Row(
                children: [
                  Text(
                    formatTime(timeMessageItem),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: lightGreyDarkMode),
                  ),
                  if (!_stateLastMsg && _islastItem && widget.isSender) ...[
                    SizedBox(width: Dimensions.height4),
                    const Icon(
                      Icons.check,
                      size: 16,
                      color: darkGreyLightMode,
                    ),
                    //     Container(
                    //       padding: EdgeInsets.symmetric(
                    //         vertical: Dimensions.height2,
                    //         horizontal: Dimensions.width10 / 2,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: widget.theme
                    //             ? darkGreyDarkMode
                    //             : lightGreyLightMode,
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.check,
                    //             size: 16,
                    //             color: widget.theme ? Colors.white : Colors.black,
                    //           ),
                    //           Text(
                    //             "đã nhận",
                    //             style: Theme.of(context).textTheme.labelSmall,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                  ],
                ],
              ),
              if (_stateLastMsg && _islastItem && widget.isSender) ...[
                SizedBox(height: Dimensions.height4),
                StateAvatar(
                  avatar: widget.avatarFriend,
                  isStatus: false,
                  radius: 16,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  _changeStateLastMsg() {
    if (_currentIndex == widget.messages.length) {
      setState(() {
        _islastItem = true;
      });
    }
    if (Message.fromJson(widget.messages.last).state == 'viewed') {
      setState(() {
        _stateLastMsg = true;
      });
    } else {
      setState(() {
        _stateLastMsg = false;
      });
    }
  }
}
