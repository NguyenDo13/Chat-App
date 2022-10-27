// ignore_for_file: invalid_use_of_visible_for_testing_member
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
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late ChatRepository chatRepository;
  final IO.Socket socket;
  final User currentUser;

  List<dynamic> listDataRoom = [];

  //source chat
  List<dynamic> sourceChat = [];
  List<String> listTime = [];
  List<dynamic>? requests = [];
  User? friend;

  ChatBloc({
    required this.socket,
    required this.listDataRoom,
    required this.requests,
    required this.currentUser,
  }) : super(HasDataRoomState(listDataRoom)) {
    checkConnectSocket();
    chatRepository = ChatRepository(
      environment: Environment(isServerDev: true),
    );

    //* Message
    on<JoinRoomEvent>(joinRoomEvent);
    on<ExitRoomEvent>((event, emit) {
      emit(HasDataRoomState(listDataRoom));
    });
    on<SendMessageEvent>(sendMessageEvent);

    //* Friend
    on<LookingForFriendEvent>(lookingForFriend);
    on<FindUserEvent>(findUserEvent);
    on<ExitFriendEvent>((event, emit) => emit(HasDataRoomState(listDataRoom)));
    on<FriendRequestEvent>(friendRequestEvent);
    on<BackToFriendRequestEvent>((event, emit) {
      emit(LookingForFriendState(init: true, requests: requests));
    });
    on<AcceptFriendRequestEvent>(acceptFriendRequestEvent);
    on<RemoveFriendRequest>(removeFriendRequest);

    updateListDataRooms();
    getFriendRequest();
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
      for (var i = 0; i < listDataRoom.length; i++) {
        if (listDataRoom[i]['room']['_id'] == data['_id']) {
          listDataRoom[i]['room'] = data;
          log(ChatRoom.fromJson(listDataRoom[i]['room']).lastMessage!);
          break;
        }
      }
    });
  }

  friendRequestEvent(FriendRequestEvent event, Emitter<ChatState> emit) {
    emit(LookingForFriendState(
      cuccessed: true,
      user: event.friend,
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
      user: User.fromJson(user.data),
      cuccessed: true,
    ));
  }

  sendMessageEvent(SendMessageEvent event, Emitter<ChatState> emit) async {
    if (currentUser.sId == null) return;

    // prepare message data
    String date = DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());
    final msg = Message(
      idSender: currentUser.sId!,
      content: event.message,
      type: 'text',
      time: date,
      state: socket.connected ? 'loading' : 'failed',
      isLast: true,
    );

    // push message into source chat with state loading
    final data = addNewMessageWhileSocketSorking(
      msg: msg,
      date: date,
      currentUser: currentUser,
      listTime: listTime,
      sourceChat: sourceChat,
    );
    sourceChat = data[0];
    listTime = data[1];

    emit(HasSourceChatState(
      isOnl: true,
      idRoom: event.idRoom,
      sourceChat: sourceChat,
      listTime: listTime,
      currentUser: currentUser,
      friend: friend!,
    ));

    if (!socket.connected) return;
    socket.emit('message', {
      'message': msg,
      'idUser': currentUser.sId,
      'idTarget': event.idTarget,
      'idRoom': event.idRoom,
    });
  }

  joinRoomEvent(JoinRoomEvent event, Emitter<ChatState> emit) async {
    friend = event.friend;
    if (!socket.connected) return;
    await getSourceChat(event.isOnl, event.roomID, event.friend);
  }

  Future getSourceChat(bool isOnl, String roomID, User friend) async {
    socket.emit('getSourceChat', {"roomID": roomID});
    socket.on('getSourceChat', (data) async {
      if (data == null) {
        return emit(HasSourceChatState(
          isOnl: isOnl,
          idRoom: roomID,
          currentUser: currentUser,
          friend: friend,
        ));
      }
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

  Future getFriendRequest() async {
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
