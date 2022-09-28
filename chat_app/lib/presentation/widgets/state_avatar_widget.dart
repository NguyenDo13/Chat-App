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
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF303030),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(40),
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
