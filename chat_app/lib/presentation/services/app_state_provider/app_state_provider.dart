import 'package:chat_app/data/models/user.dart';
import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool _darkMode = false;
  
  bool get darkMode => _darkMode;
  User get user => User(
        username: 'Nguyễn Trường Sinh',
        avatar: 'assets/images/user1.jpg',
        state: true,
        isDarkMode: _darkMode,
      );

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}
