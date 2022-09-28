import 'package:chat_app/presentation/pages/home/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(36),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ),
          );
        },
        child: Row(
          children: const [
            SizedBox(width: 14),
            Icon(
              CupertinoIcons.search,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 14),
            Text('Tìm kiếm'),
          ],
        ),
      ),
    );
  }
}
