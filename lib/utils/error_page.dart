import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/image_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/widgets/vvc_elevated_button.dart';
import 'package:vvc/widgets/vvc_heading.dart';
import 'package:vvc/widgets/vvc_sub_heading.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      body: SafeArea(
        child: Container(
          padding: VvcStyle.defaultSidePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(VvcImages.error),
              VvcStyle.defaultVerticalSpacer,
              VvcHeading(text: "error".tr),
              VvcStyle.defaultVerticalSpacer,
              VvcSubHeading(
                text: "error_message".tr,
                textAlign: TextAlign.center,
              ),
              VvcStyle.defaultVerticalSpacer,
              VvcStyle.defaultVerticalSpacer,
              VvcElevatedButton.icon(
                tooltip: "reload".tr,
                icon: Icon(CupertinoIcons.refresh_bold),
                onPressed: () {
                  //TODO:Retry Implementation
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
