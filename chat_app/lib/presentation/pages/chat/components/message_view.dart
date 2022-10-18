import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/models/message_ui.dart';
import 'package:chat_app/presentation/enum/enums.dart';
import 'package:chat_app/presentation/pages/chat/components/message_item.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageView extends StatefulWidget {
  const MessageView({
    super.key,
  });

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Expanded(
      child: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.height10,
            horizontal: Dimensions.height20,
          ),
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
            if (state is HasSourceChatState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.sourceChat.length,
                itemBuilder: (context, index) {
                  bool stateLastMsg = false;
                  bool islastItem = false;
                  if (index == state.sourceChat.length - 1) {
                    islastItem = true;
                    stateLastMsg = Message.fromJson(
                              state.sourceChat[index].last,
                            ).state ==
                            'viewed'
                        ? true
                        : false;
                  }
                  final messages = state.sourceChat[index] as List<dynamic>;
                  final idSender = Message.fromJson(messages[0]).idSender;
                  final isSender =
                      idSender == state.currentUser.sId ? true : false;
                  final time = Message.fromJson(messages.last).time;
                  return Padding(
                    padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      bottom: Dimensions.height10,
                    ),
                    child: Row(
                      mainAxisAlignment: isSender
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: isSender
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: isSender
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: messages.map((item) {
                                final msg = Message.fromJson(item);
                                return MessageItem(
                                  message: msg,
                                  theme: appState.darkMode,
                                  isSender: isSender,
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: Dimensions.height4,
                            ),
                            Row(
                              children: [
                                Text(
                                  time,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: lightGreyDarkMode),
                                ),
                                if (!stateLastMsg &&
                                    islastItem &&
                                    isSender) ...[
                                  SizedBox(
                                    width: Dimensions.height4,
                                  ),
                                  Icon(
                                    CupertinoIcons.check_mark_circled_solid,
                                    size: 16,
                                    color: appState.darkMode
                                        ? darkBlue
                                        : lightBlue,
                                  ),
                                ],
                              ],
                            ),
                            if (stateLastMsg && islastItem && isSender) ...[
                              const StateAvatar(
                                avatar: 'assets/avatars/user1.jpg',
                                isStatus: false,
                                radius: 16,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: demoMessages.length,
              itemBuilder: (context, index) {
                final messages = demoMessages[index].content!;
                return Padding(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height10,
                  ),
                  child: Row(
                    mainAxisAlignment: demoMessages[index].isSender
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // if (!demoMessages[index].isSender) ...[
                      //   StateAvatar(
                      //     avatar: 'assets/avatars/user3.jpg',
                      //     isStatus: true,
                      //     radius: Dimensions.double40,
                      //   ),
                      //   SizedBox(
                      //     width: Dimensions.width12 / 2,
                      //   ),
                      // ],
                      Column(
                        crossAxisAlignment: demoMessages[index].isSender
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: demoMessages[index].isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: messages.map((message) {
                              return _chatItem(
                                  index,
                                  message,
                                  appState.darkMode,
                                  demoMessages[index].isSender);
                            }).toList(),
                          ),
                          SizedBox(
                            height: Dimensions.height4,
                          ),
                          Text(
                            '12:00 PM',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: lightGreyDarkMode),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _chatItem(int index, String message, theme, isSender) {
    final colorBG = theme ? darkGreyDarkMode : lightGreyLightMode;
    final colorSenderBG = theme ? darkBlue : lightBlue;
    final radius20 = Radius.circular(Dimensions.double40 / 2);
    // final maxWidth = isSender
    //      Dimensions.screenWidth * 4 / 5
    //     : (Dimensions.screenWidth * 4 / 5) - Dimensions.double40;

    return Container(
      constraints: BoxConstraints(maxWidth: Dimensions.screenWidth * 4 / 5),
      margin: EdgeInsets.only(top: Dimensions.height4),
      padding: EdgeInsets.fromLTRB(
        Dimensions.height12,
        Dimensions.height16,
        Dimensions.height12,
        Dimensions.height16,
      ),
      decoration: BoxDecoration(
        color: isSender ? colorSenderBG : colorBG,
        borderRadius: BorderRadius.only(
          bottomLeft: isSender ? radius20 : const Radius.circular(0),
          bottomRight: isSender ? const Radius.circular(0) : radius20,
          topLeft: radius20,
          topRight: radius20,
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
              message,
              overflow: TextOverflow.ellipsis,
              maxLines: maxValueInteger,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white),
            )
          : Text(
              message,
              overflow: TextOverflow.ellipsis,
              maxLines: maxValueInteger,
              style: Theme.of(context).textTheme.displaySmall,
            ),
    );
  }
}
