import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:chat_app/presentation/enum/enums.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/pages/take_picture/take_picture_screen.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;

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
  late bool emojiShowing;
  List<Media> mediaList = []; // to save photos or videos have picked before

  @override
  void initState() {
    isVisibility = true;
    emojiShowing = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width14,
            vertical: Dimensions.height10,
          ),
          decoration: _decorationBox(appState),
          child: SafeArea(
            child: Row(
              children: [
                _actionIcon(
                  Icons.camera_alt,
                  () => _openCamera(),
                ),
                _actionIcon(
                  CupertinoIcons.photo,
                  () => _openImagePicker(context),
                ),
                _actionIcon(Icons.mic, () {}),
                _inputMessage(
                  appState.darkMode,
                  _onChangeInputMessage,
                  context,
                ),
                SizedBox(width: Dimensions.width14),
                InkWell(
                  onTap: () => _sendMessage(widget.controllerChat.text),
                  child: const Icon(
                    Icons.send_rounded,
                    size: 28,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        _emojiWidget(),
      ],
    );
  }

  // Widgets
  Widget _emojiWidget() {
    return Offstage(
      offstage: !emojiShowing,
      child: SizedBox(
          height: 280,
          child: EmojiPicker(
            textEditingController: widget.controllerChat,
            config: Config(
              columns: 7,
              emojiSizeMax:
                  32 * (!foundation.kIsWeb && Platform.isIOS ? 1.30 : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.RECENT,
              bgColor: const Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              showRecentsTab: true,
              recentsLimit: 28,
              replaceEmojiOnLimitExceed: false,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
              loadingIndicator: const SizedBox.shrink(),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
              checkPlatformCompatibility: true,
            ),
          )),
    );
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
            size: 28,
            color: Colors.blue,
          ),
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

  Widget _inputMessage(bool theme, onchange, BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: theme ? darkGreyDarkMode : lightGreyLightMode100,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: Dimensions.width16),
            Expanded(
              child: TextField(
                maxLines: 6,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                onTap: () => setState(() => emojiShowing = false),
                style: Theme.of(context).textTheme.displaySmall,
                controller: widget.controllerChat,
                onSubmitted: (value) => _sendMessage(value),
                onChanged: (value) => onchange(value),
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: theme ? Colors.white : darkGreyLightMode,
                      ),
                  border: InputBorder.none,
                  hintText: "Nhắn tin",
                ),
              ),
            ),
            SizedBox(width: Dimensions.width14),
            InkWell(
              onTap: () {
                setState(() {
                  emojiShowing = !emojiShowing;
                });
                FocusScope.of(context).unfocus();
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 6, 12),
                child: const Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pickerWidget(BuildContext context) {
    return MediaPicker(
      mediaList: mediaList,
      onPick: (selectedList) => _onSubmitAfterPicked(selectedList),
      onCancel: () => Navigator.pop(context),
      mediaCount: MediaCount.multiple,
      mediaType: MediaType.all,
      decoration: PickerDecoration(
        actionBarPosition: ActionBarPosition.top,
        blurStrength: 2,
        completeText: 'Gửi',
      ),
    );
  }

  // Methods
  _onSubmitAfterPicked(List<Media> selectedList) {
    setState(() => mediaList = selectedList); // update media list

    List<String> imgPathList = []; // paths of imgs were picked
    List<String> videoPathList = []; // paths of videos were picked
    for (var selected in selectedList) {
      if (selected.mediaType == MediaType.image) {
        imgPathList.add(selected.file!.path); // get img path
      } else if (selected.mediaType == MediaType.video) {
        videoPathList.add(selected.file!.path); // get img path
      }
    }
    // send imgs
    if (imgPathList.isNotEmpty) {
      _sendFiles(imgPathList, 'image'); // pass for bloc model
    }
    // send videos
    if (videoPathList.isNotEmpty) {
      _sendFiles(videoPathList, 'video'); // pass for bloc model
    }

    Navigator.pop(context);
  }

  _openImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _pickerWidget(context),
    );
  }

  Future _openCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePictureScreen(
            camera: firstCamera,
            cameras: cameras,
          ),
        ),
      );

      if (result != null) {
        _sendFiles(result, 'image');
      }
    } catch (e) {
      log("BUGS: $e");
    }
  }

  _sendFiles(List<String> listPath, String type) {
    Provider.of<ChatBloc>(context, listen: false).add(
      SendFilesEvent(
        fileType: type,
        listPath: listPath,
        roomID: widget.idRoom,
        friendID: widget.idFriend,
      ),
    );
  }

  _sendMessage(String value) {
    if (value.isNotEmpty) {
      Provider.of<ChatBloc>(context, listen: false).add(
        SendMessageEvent(
          message: value,
          idRoom: widget.idRoom,
          friendID: widget.idFriend,
        ),
      );
      setState(() {
        isVisibility = !isVisibility;
      });
      widget.controllerChat.clear();
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
}
