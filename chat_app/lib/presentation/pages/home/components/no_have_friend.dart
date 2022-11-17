import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoHaveFriend extends StatelessWidget {
  const NoHaveFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/add_friend.json',
              fit: BoxFit.fitWidth,
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ChatBloc>(context, listen: false).add(
                  LookingForFriendEvent(),
                );
              },
              child: SizedBox(
                width: 110.w,
                child: Row(
                  children: [
                    const Icon(Icons.add),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(AppLocalizations.of(context)!.add_friend),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
