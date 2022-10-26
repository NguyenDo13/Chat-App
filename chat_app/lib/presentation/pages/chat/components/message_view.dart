import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/presentation/pages/chat/components/cluster_messages.dart';
import 'package:chat_app/presentation/pages/chat/components/cluster_messages_time.dart';
import 'package:chat_app/presentation/pages/chat/components/empty_message.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageView extends StatefulWidget {
  const MessageView({
    super.key,
  });

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Expanded(
      child: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.height10,
            horizontal: Dimensions.height20,
          ),
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
            if (state is HasSourceChatState) {
              if (state.sourceChat == null) {
                return EmptyMessage(
                  friend: state.friend,
                );
              }
              final listTime = state.sourceChat.keys.toList();
              for (var time in listTime) {
                bool isShowTime = true;
                final listChat = state.sourceChat[time];
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listChat.length,
                  itemBuilder: (context, index) {
                    isShowTime = index > 0 ? false : true;
                    bool stateLastMsg = false;
                    bool islastItem = false;
                    if (index == listChat.length - 1) {
                      islastItem = true;
                      stateLastMsg = Message.fromJson(
                                listChat[index].last,
                              ).state ==
                              'viewed'
                          ? true
                          : false;
                    }
                    final messages = listChat[index] as List<dynamic>;
                    final idSender = Message.fromJson(messages[0]).idSender;
                    final isSender =
                        idSender == state.currentUser.sId ? true : false;
                    final timeMessageItem =
                        Message.fromJson(messages.last).time;
                    return Column(
                      children: [
                        if (isShowTime) ...[
                          CluterMessagesTime(
                            theme: appState.darkMode,
                            time: time,
                          ),
                        ],
                        ClusterMessages(
                          theme: appState.darkMode,
                          isSender: isSender,
                          timeMessageItem: timeMessageItem,
                          islastItem: islastItem,
                          messages: messages,
                          stateLastMsg: stateLastMsg,
                        ),
                      ],
                    );
                  },
                );
              }
            }
            return const Text('Error 500');
          }),
        ),
      ),
    );
  }
}
