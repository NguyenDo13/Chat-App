import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        SizedBox(height: 10.h),
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
