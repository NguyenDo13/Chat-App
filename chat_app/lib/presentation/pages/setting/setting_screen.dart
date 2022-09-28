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
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Center(
          child: StateAvatar(
              avatar: 'assets/avatars/user1.jpg', isStatus: false, radius: 200),
        ),
        const SizedBox(height: 20),
        Text(
          'Nguyễn Trường Sinh',
          maxLines: 4,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50),
        ListTile(
          leading: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 6, 0),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.blue[400],
            ),
            child: const Center(
              child: Icon(
                CupertinoIcons.circle_lefthalf_fill,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          title: const Text('Chế độ tối'),
          trailing: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
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
        const SizedBox(height: 10),
        _featuresSetting(
          icon: CupertinoIcons.person_circle,
          title: 'Thông tin cá nhân',
          color: Colors.deepPurple[400]!,
        ),
        const SizedBox(height: 10),
        _featuresSetting(
          icon: CupertinoIcons.person_crop_circle_badge_exclam,
          title: 'Người dùng đã chặn',
          color: Colors.orange[400]!,
        ),
        const SizedBox(height: 10),
        _featuresSetting(
          icon: Icons.logout,
          title: 'Chuyển tài khoản',
          color: Colors.pink[400]!,
        ),
      ],
    );
  }

  ListTile _featuresSetting({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return ListTile(
      onTap: () {},
      leading: Container(
        // color: Colors.blue,
        margin: const EdgeInsets.fromLTRB(12, 0, 6, 0),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: color,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
      title: Text(title),
    );
  }
}
