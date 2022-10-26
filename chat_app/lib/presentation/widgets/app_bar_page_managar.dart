import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

AppBar appBarPageManagar(
  int currentPage,
  BuildContext context,
  String img,
  String name,
  IO.Socket socket,
  int requests,
) {
  AppStateProvider appState = context.watch<AppStateProvider>();
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
    actions: [
      Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: () {
              Provider.of<ChatBloc>(context, listen: false).add(
                LookingForFriendEvent(),
              );
            },
            icon: Icon(
              CupertinoIcons.person_add_solid,
              color: appState.darkMode ? lightGreyDarkMode : darkGreyDarkMode,
              size: Dimensions.double30,
            ),
          ),
          if (requests != 0) ...[
            Positioned(
              top: Dimensions.height10,
              right: -Dimensions.height2,
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: Dimensions.height20 + Dimensions.height2),
                width: Dimensions.height20,
                height: Dimensions.height20,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.height2,
                  vertical: Dimensions.height2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.double40),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                    '$requests',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      SizedBox(width: Dimensions.width14),
    ],
  );
}
