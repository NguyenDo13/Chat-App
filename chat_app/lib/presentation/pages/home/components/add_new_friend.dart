import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewFriend extends StatelessWidget {
  final bool theme;
  const AddNewFriend({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ChatBloc>(context, listen: false).add(
          LookingForFriendEvent(focus: true),
        );
      },
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
                AppLocalizations.of(context)!.add_friend,
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
