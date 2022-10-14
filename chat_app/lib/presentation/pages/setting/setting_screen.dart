import 'package:chat_app/presentation/pages/setting/components/change_dark_mode.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/pages/setting/components/feature_setting.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authUser = context.watch<AuthBloc>().authUser;
    // Size
    final sizedBox20 = SizedBox(height: Dimensions.height20);
    final sizedBox40 = SizedBox(height: Dimensions.height10 * 4);
    final sizedBox10 = SizedBox(height: Dimensions.height10);
    // app states
    AppStateProvider appStateProvider = context.watch<AppStateProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        sizedBox20,
        _avatar(authUser.user?.urlImage ?? '', authUser.user?.name ?? "unknow"),
        sizedBox20,
        _nameOfUser(context, authUser.user?.name ?? "unknow"),
        sizedBox40,
        _changeDarkMode(appStateProvider, context, authUser.user!.sId!),
        sizedBox10,
        _changeLaguage(),
        sizedBox10,
        _userInfo(),
        sizedBox10,
        _bannedUser(),
        sizedBox10,
        _logout(context),
      ],
    );
  }

  FeatureSetting _changeLaguage() {
    return FeatureSetting(
      icon: CupertinoIcons.textformat,
      title: 'Ngôn ngữ',
      color: Colors.green[400]!,
      onTap: () {},
    );
  }

  ChangeDarkMode _changeDarkMode(
    AppStateProvider appStateProvider,
    BuildContext context,
    String userID,
  ) {
    return ChangeDarkMode(
      isDarkMode: appStateProvider.darkMode,
      onchange: (value) {
        Provider.of<AppStateProvider>(context, listen: false).changeDarkMode(
          value,
          userID,
        );
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

  Text _nameOfUser(BuildContext context, String name) {
    return Text(
      name,
      maxLines: 4,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
        shadows: [
          const BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
    );
  }

  Center _avatar(String avatar, String name) {
    return Center(
      child: StateAvatar(
        avatar: avatar,
        isStatus: false,
        text: takeLetters(name),
        radius: Dimensions.double40 * 5,
      ),
    );
  }
}
