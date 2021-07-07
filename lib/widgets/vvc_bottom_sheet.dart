import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/style_constants.dart';

class VvcBottomSheet {
  VvcBottomSheet._();

  static void showBottomSheet({
    required Widget child,
    Color? color,
    String? name,
  }) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.drag_handle),
            VvcStyle.defaultVerticalSpacer,
            Expanded(child: child),
          ],
        ),
      ),
      settings: RouteSettings(
        name: name ?? "VVC BottomSheet",
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
