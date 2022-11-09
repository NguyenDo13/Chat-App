import 'dart:developer';

import 'package:chat_app/presentation/app_authentication.dart';
import 'package:chat_app/presentation/res/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/res/colors.dart';
import 'presentation/services/app_state_provider/app_state_provider.dart';
import 'presentation/utils/functions.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseOnBackgroundMessageHandle);

    // Set Orientation of the application
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Hide status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    // Run the "Chit Chat" application
    runApp(const ChitChatApp());
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Firebase Message error: ${e.toString()}',
      fontSize: 12,
      textColor: Colors.black,
      backgroundColor: lightGreyLightMode,
    );
  }
}

class ChitChatApp extends StatefulWidget {
  const ChitChatApp({super.key});

  @override
  State<ChitChatApp> createState() => _ChitChatAppState();
}

class _ChitChatAppState extends State<ChitChatApp> {
  // Initialize SharedPreferences to get tokenUser
  late Future<SharedPreferences> sharedFuture;
  String tokenUser = '';
  String deviceToken = '';

  @override
  void initState() {
    // Get token of device
    FirebaseMessaging firebaseMsging = FirebaseMessaging.instance;
    firebaseMsging.getToken().then((value) {
      if (value == null) return;
      deviceToken = value;
      log("firebase token: $value");
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
    //   log("OPenApp: ${msg.notification!.title}");
    // });

    // FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
    //   try {
    //     log("onMessage: ${msg.notification!.title!}");
    //   } catch (e) {
    //     log("error: $e");
    //   }
    // });
    _initshared();
    _getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: Consumer<AppStateProvider>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: 'ChitChat App',
            debugShowCheckedModeBanner: false,
            theme: appState.darkMode ? AppTheme.dark() : AppTheme.light(),
            home: AppAuthentication(
              sharedFuture: sharedFuture,
              tokenUser: tokenUser,
              deviceToken: deviceToken,
            ),
          );
        },
      ),
    );
  }

  _initshared() async {
    sharedFuture = SharedPreferences.getInstance();
  }

  Future _getToken() async {
    sharedFuture.then((shared) {
      if (shared.getString('auth_token') == null) return;
      tokenUser = shared.getString('auth_token')!;
    });
  }
}
