import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';

class VvcBottomSheet {
  VvcBottomSheet._();

  static void showBottomSheet({
    required Widget child,
    Color? color,
  }) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        child: child,
      ),
      backgroundColor: color ?? VvcColors.bgColor.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }
}
