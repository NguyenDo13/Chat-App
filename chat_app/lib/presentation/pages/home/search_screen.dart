import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:chat_app/presentation/pages/home/components/input_text_field_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Scaffold(
      appBar: _buildAppbar(appState.darkMode),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.width14,
          vertical: Dimensions.height14,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width8),
                child: Text(
                  'GỢI Ý',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              SizedBox(height: Dimensions.height20),
              _buildListFriend(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar(isDarkMode) {
    return AppBar(
      toolbarHeight: Dimensions.height72,
      title: TextFieldWidget(
        padding: 0,
        boxDecorationColor: isDarkMode ? blackDarkMode! : Colors.white,
        onChanged: (value) {},
        onDeleted: () {},
        onSubmitted: (value) {},
        suffixIconColor: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildListFriend() {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Dimensions.screenHeight,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: LIST_USERS.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: Dimensions.height10),
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.only(right: Dimensions.width8),
                child: StateAvatar(
                  avatar: 'assets/avatars/${LIST_USERS[index][0].avatar}',
                  isStatus: LIST_USERS[index][0].state,
                  radius: Dimensions.double12 * 4,
                ),
              ),
              title: Text(
                LIST_USERS[index][0].username,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          );
        },
      ),
    );
  }
}
