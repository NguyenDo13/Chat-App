import 'package:chat_app/presentation/res/images_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialBtnRow extends StatelessWidget {
  const SocialBtnRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () {},
            const AssetImage(
              IMG_FB,
            ),
          ),
          _buildSocialBtn(
            () {},
            const AssetImage(
              IMG_GG,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBtn(Function()? onTap, AssetImage logo) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: 52.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white70,
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
