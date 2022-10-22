import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/widgets/list_user_widget.dart';
import 'package:chat_app/presentation/widgets/input_text_field_search.dart';
import 'package:chat_app/presentation/widgets/title_widget.dart';
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
              const TitleWidget(title: 'gợi ý', isUpper: true),
              SizedBox(height: Dimensions.height20),
              ListUserWidget(listUser: [], onTap: (){},),
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
}
