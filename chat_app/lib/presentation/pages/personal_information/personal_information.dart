import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatelessWidget {
  final String avatar;
  const PersonalInformation({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  StateAvatar(
                    avatar: avatar,
                    isStatus: false,
                    radius: Dimensions.double40 * 5,
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {},
                      icon: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
