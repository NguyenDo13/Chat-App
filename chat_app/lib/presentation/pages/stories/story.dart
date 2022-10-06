import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Story extends StatelessWidget {
  const Story({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _cardView(),
        _borderBlueAvatar(),
        _avatar(),
        _nameOfUser(context),
        _qtyStories(context),
      ],
    );
  }

  Positioned _qtyStories(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Positioned(
      top: Dimensions.height16,
      left: Dimensions.width144,
      child: Container(
        width: Dimensions.height20,
        height: Dimensions.height20,
        decoration: BoxDecoration(
          color: appState.darkMode
              ? Colors.black.withOpacity(0.4)
              : Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(Dimensions.double40),
        ),
        child: Center(
          child: Text(
            "1",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Positioned _nameOfUser(BuildContext context) {
    return Positioned(
      top: Dimensions.height24 * 10,
      left: Dimensions.width10 * 2,
      child: SizedBox(
        width: Dimensions.width120,
        child: Text(
          "Nguyễn Trường Sinh",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Positioned _avatar() {
    return Positioned(
      top: Dimensions.height20,
      left: Dimensions.width10 * 2,
      child: StateAvatar(
        avatar: 'assets/avatars/user1.jpg',
        isStatus: false,
        radius: Dimensions.double40,
      ),
    );
  }

  Positioned _borderBlueAvatar() {
    return Positioned(
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
    );
  }

  Card _cardView() {
    return Card(
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
    );
  }
}
