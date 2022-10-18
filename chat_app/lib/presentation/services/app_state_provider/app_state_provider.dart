import 'dart:async';
import 'dart:developer';

import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/repository/user_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {


  // Check connect Network
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _hasConnect = false;
  bool get hasConnect => _hasConnect;

  // setup dark mode
  late UserRepository userRepository;
  bool _darkMode = false;
  bool get darkMode => _darkMode;
  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  AppStateProvider() {
    // Initialized Connectivity
    _connectivity = Connectivity();
    // To get the realtime status of network
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      checkConnectionStatus,
    );

    // Init Repository
    userRepository = UserRepository(environment: Environment(isServerDev: true));
  }

  // post request change darkmode to server
  changeDarkMode(bool darkMode, String userID) async {
    final value = await userRepository.changeDarkMode(
      data: {'userID': userID, 'isDarkMode': darkMode},
      header: {'Content-Type': 'application/json'},
    );

    // Check correct value data
    if (value == null || value.result != 1) return;
    _darkMode = darkMode;
    notifyListeners();
  }

  // Check connect network
  Future checkConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      log('Không có mạng!');
      _hasConnect = false;
      notifyListeners();
    } else {
      log('Có mạng!');
      _hasConnect = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
