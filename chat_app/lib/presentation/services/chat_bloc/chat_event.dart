abstract class ChatEvent {
  const ChatEvent();
}

class ConnectToServer extends ChatEvent {}

class SeenMessageEvent extends ChatEvent {}
