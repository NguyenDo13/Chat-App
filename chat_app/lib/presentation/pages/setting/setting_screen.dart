import 'package:chat_app/presentation/pages/setting/components/change_dark_mode.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/pages/setting/components/feature_setting.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        ChangeDarkMode(
          isDarkMode: appStateProvider.darkMode,
          onchange: (value) {
            Provider.of<AppStateProvider>(context, listen: false).darkMode =
                value;
          },
        ),
        SizedBox(height: Dimensions.height10),
        _userInfo(),
        SizedBox(height: Dimensions.height10),
        _bannedUser(),
        SizedBox(height: Dimensions.height10),
        // Logout
        FeatureSetting(
          icon: Icons.logout,
          title: 'Chuyển tài khoản',
          color: Colors.pink[400]!,
          onTap: () {
            context.read<AuthBloc>().add(LogoutEvent());
          },
        ),
      ],
    );
  }

  FeatureSetting _bannedUser() {
    return FeatureSetting(
      icon: CupertinoIcons.person_crop_circle_badge_exclam,
      title: 'Người dùng đã chặn',
      color: Colors.orange[400]!,
      onTap: () {},
    );
  }

  FeatureSetting _userInfo() {
    return FeatureSetting(
      icon: CupertinoIcons.person_circle,
      title: 'Thông tin cá nhân',
      color: Colors.deepPurple[400]!,
      onTap: () {},
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
