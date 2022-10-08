import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class LagreButtonRound extends StatelessWidget {
  final String textButton;
  final VoidCallback onTap;
  const LagreButtonRound({
    super.key,
    required this.textButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimensions.height25),
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.height25,
          horizontal: Dimensions.width25,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: customPurple,
          borderRadius: BorderRadius.circular(Dimensions.double40),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Text(
            textButton.toUpperCase(),
            style: TextStyle(
              color: Colors.white70,
              letterSpacing: 1.5,
              fontSize: Dimensions.double36 / 2,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }
}
