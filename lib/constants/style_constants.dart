import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vvc/constants/color_constants.dart';

class VvcStyle {
  VvcStyle._();

  static const TextStyle textStyle = TextStyle(
    color: Colors.white,
  );

  static ThemeData vvcTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      primaryColor: VvcColors.primaryColor2,
      accentColor: VvcColors.accentColor1,
      appBarTheme: AppBarTheme(
        backgroundColor: VvcColors.bgColor,
        elevation: 0,
        centerTitle: true,
        textTheme: _vvcTextTheme(context),
      ),
      textTheme: _vvcTextTheme(context),
    );
  }

  static final inputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: VvcColors.primaryColor1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: VvcColors.primaryColor2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: VvcColors.fadeLightColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: VvcColors.primaryColor1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

TextTheme _vvcTextTheme(BuildContext context) {
  return GoogleFonts.comfortaaTextTheme(
    Theme.of(context).textTheme,
  ).copyWith(
    headline1: VvcStyle.textStyle,
    headline2: VvcStyle.textStyle,
    bodyText1: VvcStyle.textStyle,
    bodyText2: VvcStyle.textStyle,
    caption: VvcStyle.textStyle,
    headline3: VvcStyle.textStyle,
    headline4: VvcStyle.textStyle,
    headline5: VvcStyle.textStyle,
    headline6: VvcStyle.textStyle,
    subtitle1: VvcStyle.textStyle,
    subtitle2: VvcStyle.textStyle,
  );
}
