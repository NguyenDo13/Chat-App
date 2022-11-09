import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/models/user_presence.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOnlineUser extends StatelessWidget {
  final List<dynamic> listOnlineFriend;
  const ListOnlineUser({super.key, required this.listOnlineFriend});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {},
      child: Container(
        padding: EdgeInsets.fromLTRB(
          14.w,
          14.h,
          14.w,
          0,
        ),
        constraints: BoxConstraints(
          maxHeight: 120.h,
        ),
        // color: Colors.red,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: listOnlineFriend.length,
          itemBuilder: (BuildContext context, int index) {
            final friend = User.fromJson(listOnlineFriend[index]['friend']);
            final presence =
                UserPresence.fromJson(listOnlineFriend[index]['presence']);
            AppStateProvider appStateProvider =
                context.watch<AppStateProvider>();
            return Row(
              children: [
                if (index == 0) ...[
                  _addNewFriend(context, appStateProvider.darkMode),
                ],
                _friendWidget(friend, appStateProvider, context, presence),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _friendWidget(
    User friend,
    AppStateProvider state,
    BuildContext context,
    UserPresence presence,
  ) {
    return GestureDetector(
      onTap: () {},
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

  Widget _addNewFriend(BuildContext context, bool theme) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          margin: EdgeInsets.only(right: 12.w),
          constraints: BoxConstraints(maxWidth: 62.w),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(30.r),
                color: theme ? darkBlue : lightBlue,
                strokeWidth: 1.5,
                padding: EdgeInsets.all(2.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.r),
                  ),
                  child: Container(
                    height: 52,
                    width: 52,
                    color: theme ? darkGreyDarkMode : Colors.grey[300],
                    child: Center(
                      child: Icon(
                        Icons.add_sharp,
                        color: theme ? lightGreyLightMode : darkGreyDarkMode,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Thêm bạn",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: theme
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
