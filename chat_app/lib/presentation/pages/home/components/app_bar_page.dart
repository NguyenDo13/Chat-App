import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar appBarPage(
  int currentPage,
  BuildContext context,
  String img,
) {
  return AppBar(
    toolbarHeight: 72,
    title: Row(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
          child: Center(
            child: StateAvatar(
              avatar: img,
              isStatus: false,
              radius: 40,
            ),
          ),
        ),
        Text(TITLES_PAGE[currentPage],
            style: Theme.of(context).textTheme.headline2),
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
            const SizedBox(width: 12),
          ]
        : [],
  );
}

IconButton _actionButton(Function() action, IconData icon) {
  return IconButton(
    onPressed: action,
    icon: Icon(
      icon,
      size: 30,
    ),
  );
}
