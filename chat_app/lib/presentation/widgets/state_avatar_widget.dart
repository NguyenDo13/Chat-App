import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:flutter/material.dart';

class StateAvatar extends StatefulWidget {
  final String avatar;
  final bool isStatus;
  final double radius;
  const StateAvatar(
      {super.key,
      required this.avatar,
      required this.isStatus,
      required this.radius});

  @override
  State<StateAvatar> createState() => _StateAvatarState();
}

class _StateAvatarState extends State<StateAvatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.isStatus
          ? [
              SizedBox(
                width: widget.radius,
                height: widget.radius,
              ),
              SizedBox(
                width: widget.radius,
                height: widget.radius,
                child: CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  backgroundImage: AssetImage(widget.avatar),
                ),
              ),
              Positioned(
                bottom: widget.radius == Dimensions.double40
                    ? -Dimensions.height2
                    : Dimensions.height2,
                right: widget.radius == Dimensions.double40
                    ? -Dimensions.width10 / Dimensions.width10
                    : Dimensions.width2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height2,
                    vertical: Dimensions.height2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF303030),
                    borderRadius: BorderRadius.circular(Dimensions.double40),
                  ),
                  child: Container(
                    width: Dimensions.height10,
                    height: Dimensions.height10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(Dimensions.double40),
                    ),
                  ),
                ),
              ),
            ]
          : [
              SizedBox(
                width: widget.radius,
                height: widget.radius,
                child: CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  backgroundImage: AssetImage(widget.avatar),
                ),
              ),
            ],
    );
  }
}
