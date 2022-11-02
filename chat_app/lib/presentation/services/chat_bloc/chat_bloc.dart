// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:convert';
import 'dart:developer';
import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/models/chat_room.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/repository/chat_repository.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late ChatRepository chatRepository;
  final IO.Socket socket;
  final User currentUser;

  List<dynamic>? listDataRoom = [];
  List<dynamic>? listFriend = [];

  // Chat room
  List<dynamic> sourceChat = [];
  List<String> listTime = [];
  User? friend;

  // Friend
  List<dynamic>? requests = [];

  ChatBloc({
    required this.socket,
    this.listDataRoom,
    this.requests,
    required this.currentUser,
    this.listFriend,
  }) : super(JoinAppState(listDataRoom!, listFriend)) {
    checkConnectSocket();
    chatRepository = ChatRepository(
      environment: Environment(isServerDev: true),
    );

    //* Room
    on<JoinRoomEvent>(joinRoomEvent);
    on<CheckHasRoomEvent>(checkHasRoomEvent);
    on<ExitRoomEvent>(exitChatRoom);
    //* Message
    on<SendMessageEvent>(sendMessageEvent);
    on<SendImageEvent>(sendImageEvent);
    //* Friend
    on<LookingForFriendEvent>(lookingForFriend);
    on<FindUserEvent>(findUserEvent);
    on<ExitFriendEvent>(exitLookingForFriend);
    on<FriendRequestEvent>(friendRequestEvent);
    on<BackToFriendRequestEvent>(backToFriendRequest);
    on<AcceptFriendRequestEvent>(acceptFriendRequestEvent);
    on<RemoveFriendRequest>(removeFriendRequest);
    //* Search
    on<InitLookingForChatEvent>(initLookingForChat);
    on<ExitSearchEvent>(exitSearchFriend);

    updateListDataRooms();
    getFriendRequest();
  }

  exitSearchFriend(ExitSearchEvent event, Emitter<ChatState> emit) {
    emit(JoinAppState(listDataRoom!, listFriend));
  }

  backToFriendRequest(BackToFriendRequestEvent event, Emitter<ChatState> emit) {
    emit(LookingForFriendState(init: true, requests: requests));
  }

  initLookingForChat(InitLookingForChatEvent event, Emitter<ChatState> emit) {
    emit(LookingForChatState(listFriend: listFriend!, init: true));
  }

  exitChatRoom(ExitRoomEvent event, Emitter<ChatState> emit) {
    emit(JoinAppState(listDataRoom!, listFriend));
  }

  exitLookingForFriend(ExitFriendEvent event, Emitter<ChatState> emit) {
    emit(JoinAppState(listDataRoom!, listFriend));
  }

  removeFriendRequest(
    RemoveFriendRequest event,
    Emitter<ChatState> emit,
  ) async {
    final result = await chatRepository.removeRequest(data: {
      "userID": currentUser.sId,
      "friendID": event.friendID,
    });
    if (result == null || result.result == -1) {
      return;
    }
    requests = result.data!;
    emit(LookingForFriendState(init: true, requests: requests));
  }

  acceptFriendRequestEvent(
    AcceptFriendRequestEvent event,
    Emitter<ChatState> emit,
  ) async {
    socket.emit(
      'acceptFriendRequest',
      {"userID": currentUser.sId, "friendID": event.friendID},
    );
    requests!.removeAt(event.index);
    emit(LookingForFriendState(init: true, requests: requests));
    await updateFriends();
  }

  Future updateFriends() async {
    socket.on("updateFriends", (data) {
      listFriend = data;
    });
  }

  lookingForFriend(LookingForFriendEvent event, Emitter<ChatState> emit) async {
    final friendRequests = await chatRepository.getFriendRequests(
      data: {'userID': currentUser.sId},
    );
    if (friendRequests == null || friendRequests.result == -1) {
      requests = [];
    }
    requests = friendRequests!.data!;
    emit(LookingForFriendState(init: true, requests: requests));
  }

  updateListDataRooms() {
    socket.on("getRooms", (data) {
      bool existedRoom = false;

      for (var i = 0; i < listDataRoom!.length; i++) {
        if (listDataRoom![i]['room']['_id'] == data['room']['_id']) {
          existedRoom = true;
          listDataRoom![i]['room'] = data['room'];
          break;
        }
      }

      if (existedRoom == false) {
        listDataRoom!.add(data);
      }
    });
  }

  friendRequestEvent(FriendRequestEvent event, Emitter<ChatState> emit) {
    emit(LookingForFriendState(
      cuccessed: true,
      user: event.friend.toJson(),
      addFriendSuccess: true,
    ));

    final time = DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());
    socket.emit(
      'addFriendRequest',
      {"userID": currentUser.sId, "friendID": event.friend.sId, "time": time},
    );
  }

  Future listenResponseRequestSuccess(user) async {
    socket.on('addFriendRequestSuccess', (data) {
      if (data) {
        emit(LookingForFriendState(
          cuccessed: true,
          user: user,
          addFriendSuccess: true,
        ));
      }
    });
  }

  findUserEvent(FindUserEvent event, Emitter<ChatState> emit) async {
    emit(LookingForFriendState(finding: true));
    if (event.email == currentUser.email) {
      return emit(LookingForFriendState(failed: true));
    }
    final user = await chatRepository.findAUser(
      data: {"email": event.email, "userID": currentUser.sId},
    );
    if (user == null || user.result == -1) {
      return emit(LookingForFriendState(failed: true));
    }
    emit(LookingForFriendState(
      user: user.data,
      cuccessed: true,
    ));
  }

  sendImageEvent(SendImageEvent event, Emitter<ChatState> emit) async {
    final path = await chatRepository.sendImg(path: event.listPath[0]);
    final msg = addMessageForAsynchronousThread(path, 'image');
    log("iscurrentTime: ${msg[1]}");
    emit(HasSourceChatState(
      isOnl: true,
      idRoom: event.roomID,
      sourceChat: sourceChat,
      listTime: listTime,
      currentUser: currentUser,
      friend: friend!,
    ));

    // add new message type img
    sendMessageToServer(msg, event.friendID, event.roomID);
    await getSourceChat(true, event.roomID, friend!);
  }

  sendMessageToServer(msg, friendID, roomID) {
    if (!socket.connected) return log("SOCKET_IO NOT CONNECTION!");
    socket.emit("message", {
      'subMsg': "đã gửi 1 ảnh",
      'message': msg[0],
      'isCurrentTime': msg[1],
      'idUser': currentUser.sId,
      'idTarget': friendID,
      'idRoom': roomID,
    });
  }

  List<dynamic> addMessageForAsynchronousThread(content, type) {
    // prepare message data
    String date = DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());
    final msg = Message(
      idSender: currentUser.sId!,
      content: content,
      type: type,
      time: date,
      state: socket.connected ? 'loading' : 'failed',
    );

    // push message into source chat with state loading
    final data = addNewMessageWhileSocketWorking(
      msg: msg,
      date: date,
      currentUser: currentUser,
      listTime: listTime,
      sourceChat: sourceChat,
    );

    sourceChat = data[0];
    listTime = data[1];
    return [msg, data[2]];
  }

  sendMessageEvent(SendMessageEvent event, Emitter<ChatState> emit) async {
    if (currentUser.sId == null) return;
    final msg = addMessageForAsynchronousThread(event.message, 'text');

    emit(HasSourceChatState(
      isOnl: true,
      idRoom: event.idRoom,
      sourceChat: sourceChat,
      listTime: listTime,
      currentUser: currentUser,
      friend: friend!,
    ));

    sendMessageToServer(msg, event.friendID, event.idRoom);
    await getSourceChat(true, event.idRoom, friend!);
  }

  checkHasRoomEvent(CheckHasRoomEvent event, Emitter<ChatState> emit) async {
    String roomID = '';
    for (var element in listDataRoom!) {
      final room = ChatRoom.fromJson(element['room']);
      if (room.users!.contains(event.userID) &&
          room.users!.contains(event.friend.sId)) {
        roomID = room.sId!;
        break;
      }
    }
    if (roomID != '') {
      // Join room
      friend = event.friend;
      if (!socket.connected) return;
      socket.emit(
        'joinRoom',
        {"roomID": roomID, "userID": currentUser.sId},
      );
      await getSourceChat(event.isOnl, roomID, event.friend);
    } else {
      // Init room
      friend = event.friend;
      emit(HasSourceChatState(
        isOnl: event.isOnl,
        idRoom: "",
        currentUser: currentUser,
        friend: event.friend,
      ));
    }
  }

  joinRoomEvent(JoinRoomEvent event, Emitter<ChatState> emit) async {
    friend = event.friend;
    if (!socket.connected) return;
    socket.emit(
      'joinRoom',
      {"roomID": event.roomID, "userID": currentUser.sId},
    );
    await getSourceChat(event.isOnl, event.roomID, event.friend);
  }

  Future getSourceChat(bool isOnl, String roomID, User friend) async {
    socket.on('getSourceChat', (data) async {
      final objectSourceChat = await data['sourceChat'];
      final listKeyTime = data['sourceChat'].keys.toList();
      List<dynamic> listSourceChat = [];

      for (var element in listKeyTime) {
        listSourceChat.add(objectSourceChat[element]);
      }

      sourceChat = listSourceChat;
      listTime = listKeyTime;

      emit(HasSourceChatState(
        isOnl: isOnl,
        idRoom: roomID,
        sourceChat: listSourceChat,
        listTime: listKeyTime,
        currentUser: currentUser,
        friend: friend,
      ));
    });
  }

  getFriendRequest() {
    socket.on('friendRequest', (newRequest) {
      if (requests!.isNotEmpty) {
        requests!.add(newRequest);
      } else {
        requests = [newRequest];
      }
    });
  }

  checkConnectSocket() {
    // Connected
    socket.onConnect(
      (data) {
        log("Connection established");
        socket.emit("joinApp", currentUser.sId);
      },
    );

    // Connect error
    socket.onConnectError(
      (data) {
        log("connection failed + $data");
      },
    );

    // disconnect
    socket.onDisconnect(
      (data) {
        log("socketio Server disconnected");
      },
    );
  }
}
