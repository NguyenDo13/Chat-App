import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeDarkMode extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onchange;
  const ChangeDarkMode({
    super.key,
    required this.isDarkMode,
    required this.onchange,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
          color: Colors.blue[400],
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.circle_lefthalf_fill,
            color: Colors.white,
            size: Dimensions.double14 * 2,
          ),
        ),
      ),
      title: Text(
        'Chế độ tối',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: Container(
        margin: EdgeInsets.only(right: Dimensions.width16),
        child: Switch(
          activeColor: Colors.blue[400],
          value: isDarkMode,
          onChanged: (value) => onchange(value),
        ),
      ),
    );
  }
}
