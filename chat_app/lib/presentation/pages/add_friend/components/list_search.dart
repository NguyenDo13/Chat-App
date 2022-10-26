import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/widgets/list_user_widget.dart';
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
                  onTapItem: () {},
                  isAddFriend: true,
                  loadding: state.addFriendloading ?? false,
                  success: state.addFriendSuccess ?? false,
                  addFriend: () {
                    Provider.of<ChatBloc>(context, listen: false).add(
                      FriendRequestEvent(
                        friend: state.user!,
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
