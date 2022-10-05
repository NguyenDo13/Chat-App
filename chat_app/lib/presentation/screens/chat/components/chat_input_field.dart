import 'dart:io';
import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController controllerChat;
  const ChatInputField({super.key, required this.controllerChat});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late bool isVisibility;
  late File file;
  @override
  void initState() {
    isVisibility = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width14,
        vertical: Dimensions.height10,
      ),
      decoration: _decorationBox(appState),
      child: SafeArea(
        child: Row(
          children: [
            _actionIcon(Icons.camera_alt, _openGalleryPhotos),
            _actionIcon(CupertinoIcons.photo, () {}),
            _actionIcon(Icons.mic, () {}),
            _inputMessage(appState, _onChangeInputMessage, context),
            SizedBox(width: Dimensions.width14),
            InkWell(
              onTap: () {},
              child: const Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openGalleryPhotos() async {
  }

  _onChangeInputMessage(String value) {
    if (value.isNotEmpty) {
      setState(() {
        isVisibility = false;
      });
    } else {
      setState(() {
        isVisibility = true;
      });
    }
  }

  Widget _actionIcon(IconData icon, Function()? onTap) {
    return Visibility(
      visible: isVisibility,
      child: Container(
        padding: EdgeInsets.only(right: Dimensions.width14),
        child: InkWell(
          onTap: () => onTap,
          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _inputMessage(
    AppStateProvider appState,
    Function(String) onchange,
    BuildContext context,
  ) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(maxWidth: Dimensions.height6),
        height: Dimensions.height48,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.double40),
          color: appState.darkMode ? darkGreyDarkMode : lightGreyLightMode100,
        ),
        child: Row(
          children: [
            SizedBox(
              width: Dimensions.width16 / 2,
            ),
            Expanded(
              child: TextField(
                style: Theme.of(context).textTheme.displaySmall,
                controller: widget.controllerChat,
                onSubmitted: (value) {},
                onChanged: (value) => onchange(value),
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: appState.darkMode
                            ? Colors.white
                            : darkGreyLightMode,
                      ),
                  border: InputBorder.none,
                  hintText: "Nhắn tin",
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.width14,
            ),
            const Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decorationBox(AppStateProvider appState) {
    return BoxDecoration(
      color: appState.darkMode ? blackDarkMode : Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          offset: Offset(5, 5),
          blurRadius: 7,
        ),
      ],
    );
  }
}
