import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/controllers/profile_controller/profile_controller.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/widgets/vvc_app_bar_title.dart';
import 'package:vvc/widgets/vvc_bottom_sheet.dart';
import 'package:vvc/widgets/vvc_card.dart';
import 'package:vvc/widgets/vvc_dialog.dart';
import 'package:vvc/widgets/vvc_elevated_button.dart';
import 'package:vvc/widgets/vvc_small_text.dart';
import 'package:vvc/widgets/vvc_snackbar.dart';
import 'package:vvc/widgets/vvc_sub_heading.dart';
import 'package:vvc/widgets/vvc_text_form_field.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final ProfileController _profileController = Get.find<ProfileController>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      appBar: AppBar(
        title: VvcAppBarTitle(text: "Settings"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: VvcColors.bgColor,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //!My Account

              VvcMenuTitleCard(child: VvcSubHeading(text: "My Account")),
              _nameSection(),
              Obx(() => VvcCard(
                    onPressed: () {
                      //TODO: Change Profile Picture
                    },
                    child: ListTile(
                      title: Text("Profile Picture"),
                      trailing: _profileController.user.profilePicUrl != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                  _profileController.user.profilePicUrl!),
                            )
                          : CircleAvatar(
                              backgroundColor: VvcColors.fadeLightColor,
                              child: Icon(
                                CupertinoIcons.person,
                                color: VvcColors.bgColor,
                              ),
                            ),
                    ),
                  )),
              Obx(() => VvcCard(
                    onPressed: () {
                      //TODO: Update Email
                    },
                    child: ListTile(
                      title: Text("Email"),
                      trailing:
                          VvcSmallText(text: _profileController.user.email),
                    ),
                  )),
              VvcCard(
                child: ListTile(
                  title: Text("User ID"),
                  trailing: VvcSmallText(text: _profileController.user.id),
                ),
              ),

              //!Account Actions

              VvcMenuTitleCard(child: VvcSubHeading(text: "Account Actions")),
              VvcCard(
                onPressed: () {
                  if (!_authController.getCurrentUser!.emailVerified) {
                    _profileController.verifyUserEmail();
                  } else
                    VvcSnackBar.showSnackBar(
                        title: "Verification!",
                        message: "Your email is already verified!");
                },
                child: ListTile(
                  title: _authController.getCurrentUser!.emailVerified
                      ? Text("Email Is Verified!")
                      : Text("Verify Email"),
                  trailing: Icon(CupertinoIcons.mail),
                ),
              ),
              VvcCard(
                onPressed: () {
                  //TODO: Change Password
                },
                child: ListTile(
                  title: Text("Change Password"),
                  trailing: Icon(FontAwesomeIcons.keycdn),
                ),
              ),
              VvcCard(
                onPressed: () {
                  //TODO: Share Account
                },
                child: ListTile(
                  title: Text("Share Account"),
                  trailing: Icon(CupertinoIcons.share_up),
                ),
              ),
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
                      Get.back();
                      Get.back();
                      VvcDialog.showLoading();
                      await Get.find<AuthController>().logOut();
                      VvcDialog.hideLoading();
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
      ),
    );
  }

  Obx _nameSection() {
    return Obx(() => VvcCard(
          onPressed: () {
            VvcBottomSheet.showBottomSheet(
                child: Form(
              key: _profileController.nameFormKey,
              child: Column(
                children: [
                  VvcStyle.defaultVerticalSpacer,
                  VvcSubHeading(
                      text:
                          "Change your name. This will change the account name, Not your card names!"),
                  VvcStyle.defaultVerticalSpacer,
                  VvcTextFormField(
                    controller: _profileController.nameTextEditingController,
                    label: "New Name",
                    onValidate: (value) {
                      if (value!.length < 3) {
                        return "Name must be at least 3 characters long";
                      }
                    },
                  ),
                  VvcStyle.defaultVerticalSpacer,
                  VvcElevatedButton.text(
                    label: "Update",
                    onPressed: () {
                      if (_profileController.nameFormKey.currentState!
                          .validate()) {
                        Get.back();

                        _profileController.updateUserName(
                          name: _profileController
                              .nameTextEditingController.text
                              .trim(),
                        );
                      }
                    },
                  )
                ],
              ),
            ));
          },
          child: ListTile(
            title: Text("Name"),
            trailing:
                VvcSmallText(text: _profileController.user.name ?? "No name"),
          ),
        ));
  }
}
