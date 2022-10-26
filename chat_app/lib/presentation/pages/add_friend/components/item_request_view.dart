import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/custom_button_widget.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemRequestView extends StatelessWidget {
  final User user;
  final String time;
  final int index;
  const ItemRequestView({
    super.key,
    required this.user,
    required this.time,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Dimensions.height30,
        left: Dimensions.width12,
      ),
      constraints: BoxConstraints(maxHeight: Dimensions.height120),
      height: Dimensions.height48 * 2,
      width: Dimensions.screenWidth,
      child: Row(
        children: [
          StateAvatar(
            avatar: user.urlImage ?? '',
            isStatus: false,
            radius: 80,
          ),
          SizedBox(width: Dimensions.width10 * 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 250),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatName(name: user.name!),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      formatDay(time),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBtnWidget(
                    title: 'Xác nhận',
                    onPressed: () {
                      Provider.of<ChatBloc>(context, listen: false).add(
                        AcceptFriendRequestEvent(
                          friendID: user.sId!,
                          index: index,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: Dimensions.width12,
                  ),
                  CustomBtnWidget(
                    title: 'Xóa',
                    onPressed: () {
                      Provider.of<ChatBloc>(context, listen: false).add(
                        RemoveFriendRequest(
                          friendID: user.sId!,
                        ),
                      );
                    },
                    backgroundColor: darkGreyLightMode,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
