import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/views/profile/components/profile_body.dart';
import 'package:vvc/views/settings/settings.dart';
import 'package:vvc/widgets/vvc_app_bar_title.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      appBar: AppBar(
        title: VvcAppBarTitle(text: "profile".tr),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.settings_outlined),
                onPressed: () => Get.to(
                  () => SettingsPage(),
                ),
                tooltip: "settings".tr,
              );
            },
          ),
        ],
      ),
      body: ProfileBody(),
    );
  }
}
