import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:flutter/material.dart';


class ButtonRoundWhite extends StatelessWidget {
  final String textButton;
  final VoidCallback press;
  const ButtonRoundWhite({super.key, required this.textButton, required this.press});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimensions.height25),
        padding: EdgeInsets.all(Dimensions.width25),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.double30),
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
              color: const Color(0xFF527DAA),
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
