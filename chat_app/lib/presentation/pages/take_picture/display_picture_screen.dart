import 'dart:io';

import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        margin: EdgeInsets.only(top: Dimensions.height120),
        color: Colors.black,
        child: Column(
          children: [
            Image.file(
              File(imagePath),
              fit: BoxFit.contain,
            ),
            SizedBox(height: Dimensions.height48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: lightGreyDarkMode.withOpacity(0.5),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width120),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: lightGreyDarkMode.withOpacity(0.5),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      _sendImages(context);
                    },
                    icon: const Icon(
                      Icons.check_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _sendImages(BuildContext context) {
    Navigator.pop(context, [imagePath]);
  }
}
