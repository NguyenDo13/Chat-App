import 'package:chat_app/presentation/pages/add_friend/components/list_search.dart';
import 'package:chat_app/presentation/pages/add_friend/components/requests_new_friend.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/widgets/input_text_field_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'components/app_bar.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  @override
  Widget build(BuildContext context) {
    //* app states
    AppStateProvider appState = context.watch<AppStateProvider>();
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: Dimensions.height72,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Provider.of<ChatBloc>(context, listen: false)
                    .add(ExitFriendEvent());
              },
            ),
            title: TextFieldWidget(
              hintText: 'Nhập địa chỉ email',
              padding: 0,
              boxDecorationColor:
                  appState.darkMode ? blackDarkMode! : Colors.white,
              onChanged: (value) {},
              onDeleted: _onDelete,
              onSubmitted: (value) {
                FocusScope.of(context).unfocus();
                Provider.of<ChatBloc>(context, listen: false).add(
                  FindUserEvent(email: value),
                );
              },
              suffixIconColor: appState.darkMode ? Colors.white : Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.height14),
            child: state is LookingForFriendState && state.init!
                ? const RequestNewFriend()
                : const ListSearchUsers(),
          ),
        );
      },
    );
  }

  _onDelete() {
    FocusScope.of(context).unfocus();
  }
}
