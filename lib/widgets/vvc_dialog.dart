import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/style_constants.dart';

class VvcDialog {
  VvcDialog._();

  static void showNormalDialog({
    required Widget child,
    double width = 200,
    double? height = 200,
    bool onTouchToDismiss = true,
    String name = "VVC Normal Dialog",
  }) async {
    await Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: onTouchToDismiss
                  ? () {
                      Get.back();
                    }
                  : null,
              child: Container(
                color: VvcColors.accentColor1.withOpacity(0.1),
              ),
            ),
            Center(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [VvcColors.primaryColor1, VvcColors.primaryColor2],
                  ),
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
      name: name,
    );
  }

  static void showLoading({String? message}) async {
    showNormalDialog(
      onTouchToDismiss: false,
      name: "VVC Loading Dialog",
      child: Padding(
        padding: VvcStyle.defaultSidePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCube(
              color: Colors.white,
              size: 30,
              duration: Duration(seconds: 1),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                message ?? "loading".tr,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void hideLoading() {
    Get.back();
  }

  static void showConfirmDialog({
    required String title,
    String? confirmButtonText,
    String? cancelButtonText,
    TextStyle? confirmButtonTextStyle,
    TextStyle? cancelButtonTextStyle,
    required VoidCallback onConfirmPressed,
    VoidCallback? onCancelPressed,
    bool onTouchToDismiss = true,
  }) async {
    showNormalDialog(
      width: 250,
      height: null,
      name: "VVC Confirm Dialog",
      child: Padding(
        padding:
            const EdgeInsets.only(top: 32, left: 32, right: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
            ),
            VvcStyle.defaultVerticalSpacer,
            Align(
              alignment: Alignment.bottomRight,
              child: ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: onCancelPressed == null
                        ? () {
                            Get.back();
                          }
                        : onCancelPressed,
                    child: Text(
                      cancelButtonText ?? "cancel".tr,
                      style: cancelButtonTextStyle,
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: onConfirmPressed,
                    child: Text(
                      "yes".tr,
                      style: confirmButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
