import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class ForgotPasswordBtn extends StatelessWidget {
  const ForgotPasswordBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(Dimensions.height10),
        child: Text(
          'Forgot Password?',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}