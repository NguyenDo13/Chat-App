import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class CustomBtnWidget extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final Color? backgroundColor;
  const CustomBtnWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: Dimensions.height48,
        width: 92,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
