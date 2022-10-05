import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/screens/setting/components/feature_setting.dart';
import 'package:chat_app/presentation/services/app_state_provider.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Dimensions.height20),
        _avatar(),
        SizedBox(height: Dimensions.height20),
        _nameOfUser(context),
        SizedBox(height: Dimensions.height10 * 5),
        _darkMode(context, appStateProvider.darkMode),
        SizedBox(height: Dimensions.height10),
        _userInfo(),
        SizedBox(height: Dimensions.height10),
        _bannedUser(),
        SizedBox(height: Dimensions.height10),
        _logout(),
      ],
    );
  }

  FeatureSetting _logout() {
    return FeatureSetting(
      icon: Icons.logout,
      title: 'Chuyển tài khoản',
      color: Colors.pink[400]!,
    );
  }

  FeatureSetting _bannedUser() {
    return FeatureSetting(
      icon: CupertinoIcons.person_crop_circle_badge_exclam,
      title: 'Người dùng đã chặn',
      color: Colors.orange[400]!,
    );
  }

  FeatureSetting _userInfo() {
    return FeatureSetting(
      icon: CupertinoIcons.person_circle,
      title: 'Thông tin cá nhân',
      color: Colors.deepPurple[400]!,
    );
  }

  ListTile _darkMode(BuildContext context, isDarkMode) {
    return ListTile(
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
            Provider.of<AppStateProvider>(context, listen: false).darkMode =
                value;
          },
        ),
      ),
    );
  }

  Text _nameOfUser(BuildContext context) {
    return Text(
      'Nguyễn Trường Sinh',
      maxLines: 4,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }

  Center _avatar() {
    return Center(
      child: StateAvatar(
        avatar: 'assets/avatars/user1.jpg',
        isStatus: false,
        radius: Dimensions.double40 * 5,
      ),
    );
  }
}
