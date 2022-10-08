// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ChatState {
  late String? lastMessage;
  late String? lastTime;
  late bool? isViewed;
  ChatState({
    this.lastMessage,
    this.lastTime,
    this.isViewed,
  });
}

class InitChatState extends ChatState {}

class ActiveChatState extends ChatState {
  ActiveChatState()
      : super(
          lastMessage: 'last message',
          lastTime: 'last time',
          isViewed: false,
        );
}

class DeactiveChatState extends ChatState {
  DeactiveChatState()
      : super(
          lastMessage: 'last message',
          lastTime: 'last time',
          isViewed: false,
        );
}
