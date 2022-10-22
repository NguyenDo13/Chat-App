import 'package:chat_app/presentation/pages/add_friend/components/item_request.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class RequestNewFriend extends StatelessWidget {
  const RequestNewFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: 'Yêu cầu kết bạn', isUpper: false),
        SizedBox(height: Dimensions.height20),
        Container(
          constraints: BoxConstraints(maxHeight: Dimensions.screenHeight),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => const ItemRequestUser(),
          ),
        ),
      ],
    );
  }
}
