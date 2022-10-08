import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class FeatureSetting extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Function() onTap;
  const FeatureSetting({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        margin: EdgeInsets.fromLTRB(
          Dimensions.width14,
          0,
          Dimensions.width12 / 2,
          0,
        ),
        width: Dimensions.height10 * 5,
        height: Dimensions.height10 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.double40),
          color: color,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: Dimensions.double14 * 2,
          ),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
