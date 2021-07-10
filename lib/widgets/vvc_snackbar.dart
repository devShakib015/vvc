import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';

class VvcSnackBar {
  VvcSnackBar._();

  static void showSnackBar(
      {required String title,
      required String message,
      bool isErrorBar = false,
      int durationInSecond = 2}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: Duration(milliseconds: 500),
      duration: Duration(seconds: durationInSecond),
      backgroundGradient: isErrorBar
          ? null
          : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                VvcColors.primaryColor1,
                VvcColors.primaryColor2,
              ],
            ),
      backgroundColor:
          isErrorBar ? VvcColors.errorColor.withOpacity(0.9) : null,
      borderRadius: 10,
      margin: EdgeInsets.all(16),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static void showErrorSnackBar({required String message}) {
    showSnackBar(
      title: "Error!",
      message: message,
      isErrorBar: true,
    );
  }
}
