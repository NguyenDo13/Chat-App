import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  final bool theme;
  const SearchBar({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height44,
      margin: EdgeInsets.fromLTRB(
        Dimensions.width14,
        Dimensions.height14,
        Dimensions.width14,
        0,
      ),
      decoration: BoxDecoration(
        color: theme ? darkGreyDarkMode : lightGreyLightMode,
        borderRadius: BorderRadius.circular(Dimensions.double36),
      ),
      child: InkWell(
        onTap: () {
          context.read<ChatBloc>().add(InitLookingForChatEvent());
        },
        child: Row(
          children: [
            SizedBox(width: Dimensions.width14),
            Icon(
              CupertinoIcons.search,
              color: theme ? Colors.white : darkGreyDarkMode,
              size: Dimensions.double40 / 2,
            ),
            SizedBox(width: Dimensions.width14),
            Text(
              'Tìm kiếm',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: theme ? Colors.white : darkGreyDarkMode,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
