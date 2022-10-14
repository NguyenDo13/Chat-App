import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/models/chat_room.dart';
import 'package:chat_app/data/repository/chat_repository.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/presentation/pages/chat/chat_screen.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';

class NewListChatRoom extends StatefulWidget {
  final List<ChatRoom> listRoom;
  final bool isGroup;
  final bool? isCall;
  final String currentUserID;
  const NewListChatRoom({
    Key? key,
    required this.listRoom,
    required this.isGroup,
    this.isCall,
    required this.currentUserID,
  }) : super(key: key);

  @override
  State<NewListChatRoom> createState() => _NewListChatRoomState();
}

class _NewListChatRoomState extends State<NewListChatRoom> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Container(
      constraints: BoxConstraints(
        maxHeight: Dimensions.screenHeight,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.listRoom.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatRoomWidget(
            chatRoom: widget.listRoom[index],
            isDarkMode: appState.darkMode,
            isGroup: widget.isGroup,
            isCall: widget.isCall,
            currentUserID: widget.currentUserID,
          );
        },
      ),
    );
  }
}

class ChatRoomWidget extends StatefulWidget {
  final ChatRoom chatRoom;
  final bool isDarkMode;
  final bool isGroup;
  final bool? isCall;
  final String currentUserID;
  const ChatRoomWidget({
    super.key,
    required this.chatRoom,
    required this.isDarkMode,
    required this.isGroup,
    this.isCall,
    required this.currentUserID,
  });

  @override
  State<ChatRoomWidget> createState() => _ChatRoomWidgetState();
}

class _ChatRoomWidgetState extends State<ChatRoomWidget> {
  late final ChatRepository _chatRepository;
  User? _user;
  String? _userID;

  @override
  void initState() {
    _getUserID();
    _chatRepository = ChatRepository(
      environment: Environment(isServerDev: true),
    );
    _getInfoUserbyId();

    super.initState();
  }

  _getUserID() {
    if (widget.chatRoom.users == null) return;
    final arrayID = widget.chatRoom.users!; // [id1, id2]
    if (widget.currentUserID == arrayID[0]) {
      setState(() {
        
      _userID = arrayID[1];
      });
    } else {
      setState(() {
      _userID = arrayID[0];
        
      });
    }
  }

  // get user infomation in a room
  _getInfoUserbyId() async {
    // Post request (email, password) to server, receive response value
    final value = await _chatRepository.getInfoUserById(
      data: {'userID': _userID},
      header: {'Content-Type': 'application/json'},
    );

    // Check correct value data
    if (value == null || value.result != 1) {
      return;
    }

    // fetch data
    setState(() {
    _user = _chatRepository.convertDynamicToObject(value.data[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    // State text style which show notify that is not view
    final styleNotView = widget.isDarkMode
        ? Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: lightBlue, fontWeight: FontWeight.w400)
        : Theme.of(context).textTheme.headlineSmall;

    return ListTile(
      onTap: () {
        if (!widget.isGroup) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(),
            ),
          );
        }

        // TODO: change state item chat to viewed
      },
      visualDensity: const VisualDensity(vertical: 0.7),
      leading: StateAvatar(
        avatar: _user?.urlImage ?? '',
        text: takeLetters(_user?.name ?? 'Unknow'),
        isStatus: true,
        radius: Dimensions.double30 * 2,
      ),
      title: Container(
        margin: EdgeInsets.fromLTRB(
          0,
          Dimensions.height10,
          0,
          Dimensions.height8,
        ),
        child: Text(
          _user?.name ?? "Unknow",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      subtitle: Container(
        margin: EdgeInsets.only(
          bottom: Dimensions.height4,
        ),
        child: Row(
          children: [
            SizedBox(
              width: Dimensions.width152,
              child: Text(
                widget.chatRoom.lastMessage ?? 'Error', //* Content
                overflow: TextOverflow.ellipsis,
                style: styleNotView,
              ),
            ),
            SizedBox(
              width: Dimensions.width8 / 2,
            ),
            Text(
              '|',
              style: styleNotView,
            ),
            SizedBox(
              width: Dimensions.width8 / 2,
            ),
            Text(
              widget.chatRoom.timeLastMessage ?? 'Error', //* time
              style: styleNotView,
            ),
          ],
        ),
      ),
      trailing: widget.isCall != null
          ? Container(
              margin: EdgeInsets.fromLTRB(
                0,
                Dimensions.height10,
                0,
                Dimensions.height8,
              ),
              constraints: BoxConstraints(
                maxWidth: Dimensions.height40,
                maxHeight: Dimensions.height40,
              ),
              decoration: BoxDecoration(
                color:
                    widget.isDarkMode ? Colors.grey[800] : lightGreyLightMode,
                borderRadius: BorderRadius.circular(Dimensions.double40),
              ),
              child: Center(
                  child: Icon(
                CupertinoIcons.phone_solid,
                size: Dimensions.double40 / 2,
              )),
            )
          : null,
    );
  }
}
