import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/profile_controller/profile_controller.dart';
import 'package:vvc/widgets/vvc_elevated_button.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({
    Key? key,
  }) : super(key: key);

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: VvcStyle.defaultSidePadding,
      child: Column(
        children: [
          Obx(() => Text(_profileController.user.name ?? "No Name")),
          VvcElevatedButton.text(
            label: "Update Name",
            onPressed: () {
              _profileController.updateUserInfo(name: "Shakib");
            },
          ),
        ],
      ),
    );
  }
}