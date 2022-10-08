import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

// Login page
const boxBGAuth = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      redAccent,
      deepPurple,
      deepPurple,
      deepPurple,
      redAccent,
    ],
  ),
);

final paddingAuthLG = EdgeInsets.fromLTRB(
  Dimensions.width10 * 4,
  Dimensions.height62,
  Dimensions.width10 * 4,
  0,
);

final paddingAuthRG = EdgeInsets.fromLTRB(
  Dimensions.width10 * 4,
  Dimensions.height20,
  Dimensions.width10 * 4,
  0,
);
