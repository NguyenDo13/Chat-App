import 'dart:developer';

// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final IO.Socket _socket;

  IO.Socket get socket => _socket;
  ChatBloc(this._socket) : super(InitChatState()) {
    on<ConnectToServer>((event, emit) {
      
    });
    on<SeenMessageEvent>((event, emit) {});
  }
}
