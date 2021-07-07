import 'package:flutter/material.dart';

import 'package:vvc/constants/color_constants.dart';

class VvcSmallText extends StatelessWidget {
  final String text;
  final TextDecoration? textDecoration;
  VvcSmallText({
    Key? key,
    required this.text,
    this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: VvcColors.mainLightColor,
        fontSize: 12,
        decoration: textDecoration,
      ),
    );
  }
}
