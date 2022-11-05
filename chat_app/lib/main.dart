import 'package:chat_app/presentation/app_authentication.dart';
import 'package:chat_app/presentation/res/theme.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
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

class ChitChatApp extends StatelessWidget {
  const ChitChatApp({super.key});

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
            home: const AppAuthentication(),
          );
        },
      ),
    );
  }
}
