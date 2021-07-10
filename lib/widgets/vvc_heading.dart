import 'package:flutter/material.dart';

class VvcHeading extends StatelessWidget {
  final String text;
  const VvcHeading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
