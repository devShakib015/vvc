import 'package:flutter/material.dart';

import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/style_constants.dart';

class VvcTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onchanged;
  final String? Function(String?)? onValidate;
  final String label;
  final IconData? icon;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final bool obscure;

  const VvcTextFormField({
    Key? key,
    required this.controller,
    this.onchanged,
    this.onValidate,
    required this.label,
    this.obscure = false,
    this.icon,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: VvcColors.primaryColor2,
      onChanged: onchanged,
      validator: onValidate,
      obscureText: obscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: textInputType,
      decoration: VvcStyle.inputDecoration.copyWith(
        labelText: label,
        labelStyle: TextStyle(
          color: VvcColors.primaryColor2,
        ),
        suffixIcon: suffixIcon == null ? null : suffixIcon,
        prefixIcon: icon == null
            ? null
            : Icon(
                icon,
                color: VvcColors.primaryColor2,
              ),
      ),
    );
  }
}
