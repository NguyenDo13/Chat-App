import 'dart:developer';
import 'dart:io';

import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserAvatar extends StatefulWidget {
  final String avatar;
  final String userID;
  final bool theme;
  const UserAvatar({
    super.key,
    required this.avatar,
    required this.userID,
    required this.theme,
  });

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.height12),
            child: StateAvatar(
              avatar: widget.avatar,
              isStatus: false,
              radius: Dimensions.double30 * 4,
            ),
          ),
          Positioned(
            bottom: Dimensions.height4,
            right: Dimensions.height4,
            child: Container(
              width: Dimensions.height48 + Dimensions.height4,
              height: Dimensions.height48 + Dimensions.height4,
              decoration: BoxDecoration(
                color: const Color(0xfafafafa),
                borderRadius: BorderRadius.circular(Dimensions.double30),
              ),
              child: InkWell(
                onTap: _changeAvatar,
                child: Container(
                  margin: EdgeInsets.all(Dimensions.height6),
                  width: Dimensions.height44,
                  height: Dimensions.height44,
                  decoration: BoxDecoration(
                    color: lightGreyLightMode,
                    borderRadius: BorderRadius.circular(
                      Dimensions.double30,
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.camera_fill,
                    size: Dimensions.double40 / 2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _changeAvatar() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: Dimensions.height18 * 10,
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.height12,
            horizontal: Dimensions.height20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.height12),
              topRight: Radius.circular(Dimensions.height12),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Thay đổi ảnh đại diện',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                ),
                SizedBox(height: Dimensions.height8),
                ListTile(
                  onTap: () => _pickImage(ImageSource.camera),
                  leading: const Icon(
                    CupertinoIcons.camera_fill,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Chụp ảnh",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                ListTile(
                  onTap: () => _pickImage(ImageSource.gallery),
                  leading: const Icon(
                    CupertinoIcons.photo,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Chọn ảnh từ thư viện",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      if (!mounted) return;
      final urlImage = await Provider.of<AppStateProvider>(
        context,
        listen: false,
      ).uploadAvatar(
        image.path,
        widget.userID,
      );
      if (urlImage == null) return;
      if (!mounted) return;
      Navigator.pop(context);
    } on PlatformException catch (e) {
      log('Pick image failed: $e');
    }
  }
}
