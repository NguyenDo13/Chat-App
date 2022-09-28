import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:chat_app/presentation/widgets/input_text_field_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFieldWidget(
          padding: 0,
          boxDecorationColor: Colors.grey[900]!,
          onChanged: (value) {},
          onDeleted: () {},
          onSubmitted: (value) {},
          suffixIconColor: Colors.white,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  'GỢI Ý',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildListFriend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListFriend() {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 1000,
      ),
      child: ListView.builder(
        itemCount: LIST_USERS.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: StateAvatar(
                avatar: 'assets/avatars/${LIST_USERS[index][0].avatar}',
                isStatus: LIST_USERS[index][0].state,
                radius: 48,
              ),
            ),
            title: Text(LIST_USERS[index][0].username),
          );
        },
      ),
    );
  }
}
