import 'package:chat_app/presentation/helper/notify/alert_actions.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/list_user_widget.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:chat_app/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ListSearchUsers extends StatelessWidget {
  const ListSearchUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: 'Kết quả', isUpper: true),
        SizedBox(height: Dimensions.height20),
        BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is LookingForFriendState) {
              if (state.finding!) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.failed!) {
                return const Center(
                  child: Text("Không tìm thấy người dùng nào!"),
                );
              }
              if (state.cuccessed! && state.user != null) {
                return ListUserWidget(
                  listUser: [state.user!],
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertActions(
                        content: Container(
                          constraints: const BoxConstraints(maxHeight: 224),
                          child: Column(
                            children: [
                              Center(
                                child: StateAvatar(
                                  avatar: state.user!.urlImage ?? '',
                                  isStatus: false,
                                  text: takeLetters(state.user!.name!),
                                  radius: 180,
                                ),
                              ),
                              SizedBox(height: Dimensions.height14),
                              Text(
                                state.user!.name!,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                        nameBtn1: 'Kết bạn',
                        onTap1: () {
                          Provider.of<ChatBloc>(context).add(
                            FriendRequestEvent(
                              friendID: state.user!.sId!,
                            ),
                          );
                        },
                        nameBtn2: 'Thoát',
                        onTap2: () => Navigator.pop(context),
                      ),
                    );
                  },
                );
              }
            }
            return const Center(child: Text("Lỗi kết nối"));
          },
        ),
      ],
    );
  }
}
