import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class CannotLoadImg extends StatelessWidget {
  final bool isSender;
  final bool theme;
  const CannotLoadImg({super.key, required this.isSender, required this.theme});

  @override
  Widget build(BuildContext context) {
    // UI
    final colorBG = theme ? darkGreyDarkMode : lightGreyLightMode;
    final colorSenderBG = theme ? darkBlue : lightBlue;
    return Container(
      padding: EdgeInsets.all(Dimensions.height12),
      decoration: BoxDecoration(
        color: isSender ? colorSenderBG : colorBG,
      ),
      child: Text(
        'Không thể tải ảnh!',
        overflow: TextOverflow.ellipsis,
        maxLines: maxValueInteger,
        style: isSender
            ? Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Colors.white)
            : Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
