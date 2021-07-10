import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vvc/constants/color_constants.dart';

class VvcStyle {
  VvcStyle._();

  static final EdgeInsetsGeometry defaultSidePadding =
      EdgeInsets.symmetric(horizontal: 16);

  static final double defaultScreenHeight =
      Get.size.height - (Get.size.height * 0.08);

  static final double halfScreenWidth = Get.size.width / 2;

  static final Widget defaultVerticalSpacer = SizedBox(
    height: 15,
  );

  static final Widget defaultHorizontalSpacer = SizedBox(
    width: 15,
  );
  static final Widget defaultDivider = Divider(
    color: VvcColors.middleColor,
    height: 2,
    thickness: 1,
  );

  static TextStyle textStyle(BuildContext context) => GoogleFonts.comfortaa(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );

  static ThemeData buildTheme = ThemeData.dark().copyWith(
    primaryColor: VvcColors.primaryColor1,
    colorScheme: ColorScheme.dark().copyWith(
      secondary: VvcColors.accentColor1,
    ),
    primaryColorDark: VvcColors.primaryColor1,
    accentColorBrightness: Brightness.dark,
    accentColor: VvcColors.primaryColor1,
    backgroundColor: VvcColors.bgColor,
    scaffoldBackgroundColor: VvcColors.bgColor,
    bottomAppBarColor: VvcColors.bgColor,
    cardColor: VvcColors.bgColor,
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(VvcColors.bgColor),
      fillColor: MaterialStateProperty.all(VvcColors.primaryColor1),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all(VvcColors.mainLightColor))),
    dialogBackgroundColor: VvcColors.bgColor,
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    )),
  );

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
        color: VvcColors.middleColor,
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

  static TextTheme vvcTextTheme(BuildContext context) {
    return GoogleFonts.comfortaaTextTheme(
      Theme.of(context).textTheme,
    ).copyWith(
      headline1: VvcStyle.textStyle(context),
      headline2: VvcStyle.textStyle(context),
      bodyText1: VvcStyle.textStyle(context),
      bodyText2: VvcStyle.textStyle(context),
      caption: VvcStyle.textStyle(context),
      headline3: VvcStyle.textStyle(context),
      headline4: VvcStyle.textStyle(context),
      headline5: VvcStyle.textStyle(context),
      headline6: VvcStyle.textStyle(context),
      subtitle1: VvcStyle.textStyle(context),
      subtitle2: VvcStyle.textStyle(context),
    );
  }
}
