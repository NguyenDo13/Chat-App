import 'package:chat_app/presentation/UIData/theme.dart';
import 'package:chat_app/presentation/screens/splash/splash_screen.dart';
import 'package:chat_app/presentation/services/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: Consumer<AppStateProvider>(
        builder: (context, appState, child) {
          return GetMaterialApp(
            title: 'Chat App',
            debugShowCheckedModeBanner: false,
            theme: appState.darkMode ? AppTheme.dark() : AppTheme.light(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
