import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/presentation/pages/chat/components/loading_msg.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

import 'cannot_load_img.dart';

class ImageMessage extends StatelessWidget {
  final bool isSender;
  final bool theme;
  final String path;
  const ImageMessage(
      {super.key,
      required this.isSender,
      required this.theme,
      required this.path,});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: Dimensions.screenWidth * 7 / 10,
        maxHeight: Dimensions.height220 * 2,
      ),
      margin: EdgeInsets.only(top: Dimensions.height2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.double12),
        boxShadow: [
          BoxShadow(
            color: isSender ? Colors.black45 : Colors.black12,
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.double16 / 2),
        child: CachedNetworkImage(
          imageUrl: "https://appsocketonline2.herokuapp.com$path",
          fit: BoxFit.contain,
          placeholder: (context, url) => LoadingMessage(
            width: 214,
            isSender: isSender,
            theme: theme,
            content: 'Đang tải lên 1 ảnh!',
          ),
          errorWidget: (context, url, error) => CannotLoadMsg(
            isSender: isSender,
            theme: theme,
            content: 'Không thể tải ảnh!',
          ),
        ),
      ),
    );
  }
}
