import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              VvcHeading(text: "Something Went Wrong!"),
              VvcStyle.defaultVerticalSpacer,
              VvcSubHeading(
                text:
                    "There might be issues about internet connection or the page is not available. Please be patient and try again. If the app doesn't work as expected, check your internet connection and relaunch the app. Thank you!",
                textAlign: TextAlign.center,
              ),
              VvcStyle.defaultVerticalSpacer,
              VvcStyle.defaultVerticalSpacer,
              VvcElevatedButton.icon(
                tooltip: "Reload",
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
