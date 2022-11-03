import 'package:chat_app/presentation/pages/information_chat_room/information_chat_room.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

AppBar buildAppBar({
  required BuildContext context,
  required String roomID,
}) {
  final friend = context.watch<ChatBloc>().friend;
  return AppBar(
    toolbarHeight: Dimensions.height72,
    leading: BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<ChatBloc>(context, listen: false).add(ExitRoomEvent(roomID: roomID));
          },
        );
      },
    ),
    title: BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is HasSourceChatState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StateAvatar(
                avatar: state.friend.urlImage!,
                isStatus: state.isOnl,
                radius: Dimensions.double40,
              ),
              SizedBox(
                width: Dimensions.width12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatName(name: state.friend.name!),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (state.isOnl) ...[
                    Text(
                      "Đang hoạt động",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontSize: 10),
                    ),
                  ]
                ],
              ),
            ],
          );
        }
        return const Center(child: Text("error"));
      },
    ),
    actions: [
      // IconButton(
      //   onPressed: () {},
      //   icon: Icon(
      //     Icons.phone,
      //     color: Colors.blue,
      //     size: Dimensions.double12 * 2,
      //   ),
      // ),
      // IconButton(
      //   onPressed: () {},
      //   icon: Icon(
      //     Icons.videocam_rounded,
      //     size: Dimensions.double30,
      //   ),
      // ),
      IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InformationChatRoomScreen(friend: friend!),
              ));
        },
        icon: Icon(
          CupertinoIcons.info_circle_fill,
          color: Colors.blue,
          size: Dimensions.double30,
        ),
      ),
      SizedBox(
        width: Dimensions.height4,
      ),
    ],
  );
}
