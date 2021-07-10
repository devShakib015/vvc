import 'package:flutter/material.dart';

import 'package:vvc/constants/color_constants.dart';

class VvcSubHeading extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const VvcSubHeading({
    Key? key,
    required this.text,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: VvcColors.mainLightColor,
        fontSize: 13,
      ),
    );
  }
}
