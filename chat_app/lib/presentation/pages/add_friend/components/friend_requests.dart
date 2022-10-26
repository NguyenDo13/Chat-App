import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/pages/add_friend/components/item_request_view.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class FriendRequestView extends StatelessWidget {
  final List<dynamic> friendRequests;
  const FriendRequestView({super.key, required this.friendRequests});

  @override
  Widget build(BuildContext context) {
    print("data: " + friendRequests.length.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: 'Yêu cầu kết bạn', isUpper: false),
        SizedBox(height: Dimensions.height20),
        Container(
          constraints: BoxConstraints(maxHeight: Dimensions.screenHeight),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friendRequests.length,
            itemBuilder: (context, index) {
              final user = User.fromJson(friendRequests[index]['user']);
              final time = friendRequests[index]['time'];
              return ItemRequestView(
                index: index,
                user: user,
                time: time,
              );
            },
          ),
        ),
      ],
    );
  }
}
