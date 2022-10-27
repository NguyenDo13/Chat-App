import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class CluterMessagesTime extends StatelessWidget {
  final bool theme;
  final String time;
  const CluterMessagesTime(
      {super.key, required this.theme, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.height4,
        horizontal: Dimensions.width10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.double30),
        color: theme ? darkGreyDarkMode : lightGreyLightMode,
      ),
      child: Text(
        time,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
