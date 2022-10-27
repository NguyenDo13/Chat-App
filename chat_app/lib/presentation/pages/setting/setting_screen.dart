import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/pages/personal_information/personal_information.dart';
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
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class SettingScreen extends StatelessWidget {
  final IO.Socket socket;
  final AuthUser authUser;
  const SettingScreen(
      {super.key, required this.authUser, required this.socket});
  @override
  Widget build(BuildContext context) {
    // Size
    final sizedBox24 = SizedBox(height: Dimensions.height24);
    final sizedBox50 = SizedBox(height: Dimensions.height10 * 5);
    final sizedBox12 = SizedBox(height: Dimensions.height12);
    // app states
    AppStateProvider appStateProvider = context.watch<AppStateProvider>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizedBox24,
          _avatar(
            authUser.user?.urlImage ?? '',
            authUser.user?.name ?? "unknow",
          ),
          sizedBox24,
          _nameOfUser(context, authUser.user?.name ?? "unknow"),
          sizedBox50,
          _changeDarkMode(appStateProvider, context, authUser.user!.sId!),
          sizedBox12,
          _changeLaguage(),
          sizedBox12,
          _userInfo(context),
          sizedBox12,
          _bannedUser(),
          sizedBox12,
          _logout(context),
        ],
      ),
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
        context.read<AuthBloc>().add(LogoutEvent(socket: socket));
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

  FeatureSetting _userInfo(BuildContext context) {
    return FeatureSetting(
      icon: CupertinoIcons.person_circle,
      title: 'Thông tin cá nhân',
      color: Colors.deepPurple[400]!,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalInformation(
              avatar: authUser.user?.urlImage ?? '',
            ),
          ),
        );
      },
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
        radius: Dimensions.double40 * 5,
      ),
    );
  }
}
