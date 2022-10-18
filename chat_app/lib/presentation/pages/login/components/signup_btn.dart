import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBtn extends StatelessWidget {
  const SignupBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height8),
            child: const Text(
              'Don\'t have an Account?',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: Dimensions.width8),
          InkWell(
            onTap: () {
              context.read<AuthBloc>().add(InitRegisterEvent());
            },
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 20,
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