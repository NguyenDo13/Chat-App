import 'package:flutter/material.dart';

Stack buildStateNavigationItem({required IconData icon, String? valueState}) {
  return Stack(
    children: valueState != null
        ? [
            Icon(
              icon,
              size: 32,
            ),
            Positioned(
              top: 0,
              right: -2,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 19),
                width: 19,
                height: 19,
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF303030),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                    valueState,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
          ]
        : [
            Icon(
              icon,
              size: 32,
            ),
          ],
  );
}
