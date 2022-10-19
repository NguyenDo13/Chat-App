import 'package:chat_app/presentation/pages/add_friend/components/app_bar.dart';
import 'package:chat_app/presentation/pages/add_friend/components/requests_new_friend.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  late bool stateAddFriend;
  @override
  void initState() {
    stateAddFriend = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // app states
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Scaffold(
      appBar: buildAppbar(
        isDarkMode: appState.darkMode,
        onChange: (value) => _onChange(value),
        onSubmit: (value) => _onSubmit(value),
      ),
      body: stateAddFriend ? const RequestNewFriend() : Container(),
    );
  }

  _onChange(String name) {
    setState(() {
      stateAddFriend = true;
    });
  }

  _onSubmit(String name) {}
}
