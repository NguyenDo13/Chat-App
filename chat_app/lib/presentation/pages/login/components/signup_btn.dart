import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupBtn extends StatelessWidget {
  const SignupBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Text(
              'Don\'t have an Account?',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.h,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: () {
              context.read<AuthBloc>().add(InitRegisterEvent());
            },
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 20.h,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
