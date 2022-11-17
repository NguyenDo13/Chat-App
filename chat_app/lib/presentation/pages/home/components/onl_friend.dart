import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/models/user_presence.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OnlFriend extends StatelessWidget {
  final User friend;
  final AppStateProvider state;
  final UserPresence presence;
  const OnlFriend({
    super.key,
    required this.friend,
    required this.state,
    required this.presence,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final userID =
            Provider.of<ChatBloc>(context, listen: false).currentUser.sId;
        Provider.of<ChatBloc>(context, listen: false).add(
          CheckHasRoomEvent(
            userID: userID!,
            friend: friend,
            isOnl: presence.presence!,
          ),
        );
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(right: 12.w),
          constraints: BoxConstraints(maxWidth: 62.w),
          child: Column(
            children: [
              StateAvatar(
                avatar: friend.urlImage ?? '',
                isStatus: presence.presence!,
                radius: 60.r,
              ),
              SizedBox(height: 4.h),
              Text(
                friend.name ?? "UNKNOWN",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: state.darkMode
                    ? Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white)
                    : Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
