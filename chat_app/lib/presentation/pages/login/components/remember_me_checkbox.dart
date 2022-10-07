// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';

// ignore: must_be_immutable
class RememberMeCheckbox extends StatefulWidget {
  late bool rememberMe;
  final Function(bool?)? onChange;
  RememberMeCheckbox({
    Key? key,
    required this.rememberMe, this.onChange,
  }) : super(key: key);

  @override
  State<RememberMeCheckbox> createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white70),
            child: Checkbox(
              value: widget.rememberMe,
              checkColor: deepPurple,
              activeColor: Colors.white70,
              onChanged: widget.onChange,
            ),
          ),
          Text(
            'Remember me',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
