import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Story extends StatelessWidget {
  const Story({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.double30 / 3),
          ),
          elevation: 5,
          margin: EdgeInsets.symmetric(
            horizontal: Dimensions.width10,
            vertical: Dimensions.height10,
          ),
          child: SizedBox(
            height: Dimensions.height14 * 20,
            child: Image.asset(
              'assets/avatars/user3.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          top: Dimensions.height20 - Dimensions.height2,
          left: Dimensions.width10 * 2 - Dimensions.height2,
          child: Container(
            width: Dimensions.double40 + Dimensions.height4,
            height: Dimensions.double40 + Dimensions.height4,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(Dimensions.double40),
            ),
          ),
        ),
        Positioned(
          top: Dimensions.height20,
          left: Dimensions.width10 * 2,
          child: StateAvatar(
            avatar: 'assets/avatars/user1.jpg',
            isStatus: false,
            radius: Dimensions.double40,
          ),
        ),
        Positioned(
          top: Dimensions.height24 * 10,
          left: Dimensions.width10 * 2,
          child: SizedBox(
            width: Dimensions.width120,
            child: Text(
              "Nguyễn Trường Sinh",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        Positioned(
          top: Dimensions.height16,
          left: Dimensions.width144,
          child: Container(
            width: Dimensions.height20,
            height: Dimensions.height20,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(Dimensions.double40)),
            child: Center(
              child: Text(
                "1",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
