import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Story extends StatelessWidget {
  const Story({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: SizedBox(
            height: 280,
            child: Image.asset(
              'assets/avatars/user3.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          top: 18,
          left: 18,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        const Positioned(
          top: 20,
          left: 20,
          child: StateAvatar(
            avatar: 'assets/avatars/user1.jpg',
            isStatus: false,
            radius: 40,
          ),
        ),
        Positioned(
          top: 240,
          left: 20,
          child: SizedBox(
            width: 120,
            child: Text(
              "Nguyễn Trường Sinh",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 144,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(40)),
            child: Center(
              child: Text(
                "1",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.openSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
