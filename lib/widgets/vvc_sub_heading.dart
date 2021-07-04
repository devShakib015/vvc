import 'package:flutter/material.dart';

import 'package:vvc/constants/color_constants.dart';

class VvcSubHeading extends StatelessWidget {
  final String text;
  const VvcSubHeading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: VvcColors.mainLightColor,
        fontSize: 14,
      ),
    );
  }
}
