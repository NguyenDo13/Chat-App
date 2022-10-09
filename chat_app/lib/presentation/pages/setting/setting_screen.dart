import 'package:chat_app/presentation/pages/setting/components/change_dark_mode.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/pages/setting/components/feature_setting.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Size
    final sizedBox20 = SizedBox(height: Dimensions.height20);
    final sizedBox50 = SizedBox(height: Dimensions.height10 * 5);
    final sizedBox10 = SizedBox(height: Dimensions.height10);
    // Provider state app
    AppStateProvider appStateProvider = context.watch<AppStateProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        sizedBox10,
        _avatar(),
        sizedBox10,
        _nameOfUser(context),
        sizedBox20,
        _changeDarkMode(appStateProvider, context),
        sizedBox10,
        FeatureSetting(
          icon: CupertinoIcons.textformat,
          title: 'Ngôn ngữ',
          color: Colors.green[400]!,
          onTap: () {},
        ),
        sizedBox10,
        _userInfo(),
        sizedBox10,
        _bannedUser(),
        sizedBox10,
        _logout(context),
      ],
    );
  }

  ChangeDarkMode _changeDarkMode(
      AppStateProvider appStateProvider, BuildContext context) {
    return ChangeDarkMode(
      isDarkMode: appStateProvider.darkMode,
      onchange: (value) {
        Provider.of<AppStateProvider>(context, listen: false).darkMode = value;
      },
    );
  }

  FeatureSetting _logout(BuildContext context) {
    return FeatureSetting(
      icon: Icons.logout,
      title: 'Chuyển tài khoản',
      color: Colors.pink[400]!,
      onTap: () {
        context.read<AuthBloc>().add(LogoutEvent());
      },
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
