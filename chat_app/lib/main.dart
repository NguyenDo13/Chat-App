import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/repository/auth_repository.dart';
import 'package:chat_app/presentation/pages/app_home.dart';
import 'package:chat_app/presentation/res/theme.dart';
import 'package:chat_app/presentation/app_controller.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late Future<SharedPreferences> shared;
  _initshared() async {
    shared = SharedPreferences.getInstance();
  }

  @override
  void initState() {
    _initshared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: Consumer<AppStateProvider>(
        builder: (context, appState, child) {
          return BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              AuthRepository(
                environment: Environment(isServerDev: true),
              ),
              shared,
            ),
            child: GetMaterialApp(
              title: 'Chat App',
              debugShowCheckedModeBanner: false,
              theme: appState.darkMode ? AppTheme.dark() : AppTheme.light(),
              home: const AppHome(),
            ),
          );
        },
      ),
    );
  }
}
