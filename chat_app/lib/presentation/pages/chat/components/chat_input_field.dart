import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/pages/take_picture/take_picture_screen.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController controllerChat;
  final String idRoom;
  final String idFriend;
  const ChatInputField({
    super.key,
    required this.controllerChat,
    required this.idRoom,
    required this.idFriend,
  });

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
            _actionIcon(Icons.camera_alt, () => _openCamera()),
            _actionIcon(CupertinoIcons.photo, () {}),
            _actionIcon(Icons.mic, () {}),
            _inputMessage(
              appState,
              _onChangeInputMessage,
              context,
              widget.idRoom,
              widget.idFriend,
            ),
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

  Future _openCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePictureScreen(camera: firstCamera),
        ),
      );
    } catch (e) {
      log("BUGS:$e");
    }
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
          onTap: onTap,
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
    String idRoom,
    String idFriend,
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
                onSubmitted: (value) {
                  Provider.of<ChatBloc>(context, listen: false).add(
                    SendMessageEvent(
                      message: value,
                      idRoom: idRoom,
                      idTarget: idFriend,
                    ),
                  );
                  setState(() {
                    isVisibility = !isVisibility;
                  });
                  widget.controllerChat.clear();
                },
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
