import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class StateBottomNavigationBar extends StatelessWidget {
  final IconData icon;
  final String? valueState;
  const StateBottomNavigationBar({
    super.key,
    required this.icon,
    this.valueState,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: valueState != null
          ? [
              Icon(
                icon,
                size: Dimensions.height14 * 2,
              ),
              Positioned(
                top: -Dimensions.height2,
                right: -Dimensions.height2,
                child: Container(
                  constraints: BoxConstraints(maxWidth: Dimensions.height20),
                  width: Dimensions.height20,
                  height: Dimensions.height20,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height2,
                    vertical: Dimensions.height2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.double40),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text(
                      valueState ?? '',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ]
          : [
              Icon(
                icon,
                size: Dimensions.height14 * 2,
              ),
            ],
    );
  }
}
