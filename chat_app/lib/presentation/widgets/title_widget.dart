import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final bool isUpper;
  const TitleWidget({super.key, required this.title, required this.isUpper});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width8),
      child: Text(
        isUpper ? title.toUpperCase() : title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
