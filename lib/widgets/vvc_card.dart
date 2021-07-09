import 'package:flutter/material.dart';

import 'package:vvc/constants/color_constants.dart';

class VvcCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const VvcCard({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: ShapeDecoration(
          shadows: [],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [VvcColors.primaryColor1, VvcColors.primaryColor2],
          ),
        ),
        child: child,
      ),
    );
  }
}
