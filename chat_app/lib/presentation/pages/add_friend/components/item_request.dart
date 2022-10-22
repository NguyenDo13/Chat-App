import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/widgets/custom_button_widget.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';

class ItemRequestUser extends StatelessWidget {
  const ItemRequestUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Dimensions.height30,
        left: Dimensions.width12,
      ),
      constraints: BoxConstraints(maxHeight: Dimensions.height120),
      height: Dimensions.height48 * 2,
      width: Dimensions.screenWidth,
      child: Row(
        children: [
          const StateAvatar(
            avatar: 'assets/avatars/user1.jpg',
            isStatus: false,
            radius: 80,
          ),
          SizedBox(width: Dimensions.width10 * 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trường Sinh",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(width: Dimensions.width44),
                  Text(
                    "1 ngày trước",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBtnWidget(
                    title: 'Xác nhận',
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: Dimensions.width12,
                  ),
                  CustomBtnWidget(
                    title: 'Xóa',
                    onPressed: () {},
                    backgroundColor: darkGreyLightMode,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
