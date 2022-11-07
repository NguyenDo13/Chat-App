import 'package:chat_app/presentation/app_authentication.dart';
import 'package:chat_app/presentation/res/theme.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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

  @override
  void initState() {
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
          return GetMaterialApp(
            title: 'ChitChat App',
            debugShowCheckedModeBanner: false,
            theme: appState.darkMode ? AppTheme.dark() : AppTheme.light(),
            home: AppAuthentication(
              sharedFuture: sharedFuture,
              tokenUser: tokenUser,
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
