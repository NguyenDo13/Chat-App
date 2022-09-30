import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar appBarPage(
  int currentPage,
  BuildContext context,
  String img,
) {
  return AppBar(
    toolbarHeight: Dimensions.height72,
    title: Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: Dimensions.width16),
          child: Center(
            child: StateAvatar(
              avatar: img,
              isStatus: false,
              radius: Dimensions.double40,
            ),
          ),
        ),
        Text(
          TITLES_PAGE[currentPage],
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ],
    ),
    actions: currentPage == 0
        ? [
            _actionButton(
              () {},
              Icons.camera_alt,
            ),
            _actionButton(
              () {},
              CupertinoIcons.pencil,
            ),
            SizedBox(width: Dimensions.width14),
          ]
        : [],
  );
}

IconButton _actionButton(Function() action, IconData icon) {
  return IconButton(
    onPressed: action,
    icon: Icon(
      icon,
      size: Dimensions.double30,
    ),
  );
}
