import 'package:flutter/material.dart';
import 'package:vvc/constants/color_constants.dart';

class VvcCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  const VvcCard({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: ShapeDecoration(
          shadows: [],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [VvcColors.accentColor1, VvcColors.accentColor2],
          ),
        ),
        child: child,
      ),
    );
  }
}

class VvcMenuTitleCard extends StatelessWidget {
  final Widget child;

  const VvcMenuTitleCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: child,
    );
  }
}
