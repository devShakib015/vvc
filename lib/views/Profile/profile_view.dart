import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/views/profile/components/profile_body.dart';
import 'package:vvc/widgets/vvc_app_bar_title.dart';
import 'package:vvc/widgets/vvc_card.dart';
import 'package:vvc/widgets/vvc_dialog.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _settingsDrawer(),
      backgroundColor: VvcColors.bgColor,
      appBar: AppBar(
        title: VvcAppBarTitle(text: "Profile"),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ],
      ),
      body: ProfileBody(),
    );
  }

  Drawer _settingsDrawer() {
    return Drawer(
      child: Container(
        color: VvcColors.bgColor,
        padding: VvcStyle.defaultSidePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() => VvcCard(
                  onPressed: () {
                    Get.find<StorageController>().updateOnBoardingStorage(
                        !Get.find<StorageController>().isOnBoardingShown);
                  },
                  child: Get.find<StorageController>().isOnBoardingShown
                      ? ListTile(
                          title: Text("Turn On Onboarding!"),
                          trailing: Icon(Icons.toggle_off),
                        )
                      : ListTile(
                          title: Text("Turn Off Onboarding!"),
                          trailing: Icon(Icons.toggle_on),
                        ),
                )),
            VvcCard(
              onPressed: () {
                VvcDialog.showConfirmDialog(
                  title: "Are you sure to log out?",
                  onConfirmPressed: () async {
                    await Get.find<AuthController>().logOut();
                    Get.back();
                  },
                );
              },
              child: ListTile(
                title: Text("Log Out"),
                trailing: Icon(Icons.logout),
              ),
            )
          ],
        ),
      ),
    );
  }
}
