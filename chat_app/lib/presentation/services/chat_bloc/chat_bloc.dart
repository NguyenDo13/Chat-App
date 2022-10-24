// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:developer';
import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/models/chat_room.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/repository/chat_repository.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
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
  dynamic sourceChat = [];

  List<dynamic>? requests = [];

  ChatBloc({
    required this.socket,
    required this.currentUser,
  }) : super(InitDataRoomState()) {
    chatRepository = ChatRepository(
      environment: Environment(isServerDev: true),
    );
    checkConnectSocket();

    //* Room
    on<GetDataRoomsEvent>(getDataRoomsEvent);

    //* Message
    on<JoinRoomEvent>(joinRoomEvent);
    on<ExitRoomEvent>((event, emit) {
      emit(HasDataRoomState(listDataRoom));
    });
    on<SendMessageEvent>(sendMessageEvent);

    //* Friend
    on<LookingForFriendEvent>((event, emit) async {
      final friendRequests = await chatRepository.getFriendRequests(
        data: {'userID': currentUser.sId},
      );
      if (friendRequests == null || friendRequests.result == -1) {
        return;
      }
      requests = friendRequests.data!;
      emit(LookingForFriendState(init: true, requests: requests));
    });
    on<FindUserEvent>(findUserEvent);
    on<ExitFriendEvent>((event, emit) => emit(HasDataRoomState(listDataRoom)));
    on<FriendRequestEvent>(friendRequestEvent);
    on<BackToFriendRequestEvent>((event, emit) {
      emit(LookingForFriendState(init: true, requests: requests));
    });
    on<AcceptFriendRequestEvent>((event, emit) {
      socket.emit(
        'acceptFriendRequest',
        {"userID": currentUser.sId, "friendID": event.friendID},
      );
      requests!.removeAt(event.index);
      emit(LookingForFriendState(init: true, requests: requests));
    });
    updateListDataRooms();
    getFriendRequest();
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
    final time = DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());
    socket.emit(
      'addFriendRequest',
      {"userID": currentUser.sId, "friendID": event.friendID, "time": time},
    );
  }

  findUserEvent(FindUserEvent event, Emitter<ChatState> emit) async {
    if (!socket.connected) return;
    emit(LookingForFriendState(finding: true));
    final user = await chatRepository.findAUser(
      data: {"email": event.email},
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
    if (!socket.connected) return;
    if (currentUser.sId == null) return;
    await sendMessage(
      message: event.message,
      target: event.idTarget,
      room: event.idRoom,
    );
  }

  Future sendMessage({
    required String message,
    required String target,
    required String room,
  }) async {
    String date = DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());
    final msg = Message(
      idSender: currentUser.sId!,
      content: message,
      type: 'text',
      time: date,
      state: 'notView',
      isLast: true,
    );
    socket.emit('message', {
      'message': msg,
      'idUser': currentUser.sId,
      'idTarget': target,
      'idRoom': room,
    });
  }

  joinRoomEvent(JoinRoomEvent event, Emitter<ChatState> emit) async {
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
      sourceChat = await data['sourceChat'];
      emit(HasSourceChatState(
        isOnl: isOnl,
        idRoom: roomID,
        sourceChat: sourceChat,
        currentUser: currentUser,
        friend: friend,
      ));
    });
  }

  getDataRoomsEvent(GetDataRoomsEvent event, Emitter<ChatState> emit) async {
    socket.emit("joinApp", currentUser.sId);
    if (currentUser.sId == null) return;
    final rooms = await chatRepository.getRooms(
      data: {"userID": currentUser.sId},
    );
    if (rooms == null || rooms.result == -1) return;
    listDataRoom = rooms.data;
    emit(HasDataRoomState(listDataRoom));
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
        add(GetDataRoomsEvent());
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
