import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/pages/setting/components/feature_setting.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late bool isDarkMode;

  @override
  void initState() {
    isDarkMode = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Dimensions.height20),
        Center(
          child: StateAvatar(
            avatar: 'assets/avatars/user1.jpg',
            isStatus: false,
            radius: Dimensions.double40 * 5,
          ),
        ),
        SizedBox(height: Dimensions.height20),
        Text(
          'Nguyễn Trường Sinh',
          maxLines: 4,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        SizedBox(height: Dimensions.height10 * 5),
        ListTile(
          leading: Container(
            margin: EdgeInsets.fromLTRB(
              Dimensions.width14,
              0,
              Dimensions.width12 / 2,
              0,
            ),
            width: Dimensions.height10 * 5,
            height: Dimensions.height10 * 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.double40),
              color: Colors.blue[400],
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.circle_lefthalf_fill,
                color: Colors.white,
                size: Dimensions.double14 * 2,
              ),
            ),
          ),
          title: Text(
            'Chế độ tối',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Container(
            margin: EdgeInsets.only(right: Dimensions.width16),
            child: Switch(
              activeColor: Colors.blue[400],
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: Dimensions.height10),
        FeatureSetting(
          icon: CupertinoIcons.person_circle,
          title: 'Thông tin cá nhân',
          color: Colors.deepPurple[400]!,
        ),
        SizedBox(height: Dimensions.height10),
        FeatureSetting(
          icon: CupertinoIcons.person_crop_circle_badge_exclam,
          title: 'Người dùng đã chặn',
          color: Colors.orange[400]!,
        ),
        SizedBox(height: Dimensions.height10),
        FeatureSetting(
          icon: Icons.logout,
          title: 'Chuyển tài khoản',
          color: Colors.pink[400]!,
        ),
      ],
    );
  }
}
