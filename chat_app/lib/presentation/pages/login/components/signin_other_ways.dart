import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class SignInOtherWays extends StatelessWidget {
  const SignInOtherWays({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: Dimensions.height10),
        Text(
          'Sign in with',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
