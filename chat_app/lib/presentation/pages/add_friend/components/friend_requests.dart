import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/pages/add_friend/components/item_request_view.dart';
import 'package:chat_app/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendRequestView extends StatelessWidget {
  final List<dynamic> friendRequests;
  const FriendRequestView({super.key, required this.friendRequests});

  @override
  Widget build(BuildContext context) {
    final maxHieght = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: 'Yêu cầu kết bạn', isUpper: false),
        SizedBox(height: 20.h),
        Container(
          constraints: BoxConstraints(maxHeight: maxHieght),
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
