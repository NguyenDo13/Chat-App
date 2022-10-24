import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class CluterMessagesTime extends StatelessWidget {
  final bool theme;
  final String time;
  const CluterMessagesTime({super.key, required this.theme, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height12),
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.height6,
        horizontal: Dimensions.width25,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme ? darkGreyDarkMode : lightGreyLightMode,
      ),
      child: Text(
        time,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
