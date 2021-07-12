import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/image_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/controllers/profile_controller/profile_controller.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/utils/privacy_policy.dart';
import 'package:vvc/utils/terms_and_conditions.dart';
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
      appBar: AppBar(
        title: VvcAppBarTitle(text: "Settings"),
        actions: [
          IconButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: _profileController.appName,
                applicationIcon: Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(VvcImages.logo)),
                applicationLegalese: "devShakib",
                applicationVersion: _profileController.version,
              );
            },
            icon: Icon(CupertinoIcons.info_circle),
          )
        ],
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
                    onPressed: _profileController.updateUserProfilePic,
                    child: ListTile(
                      title: Text("Profile Picture"),
                      subtitle: VvcSmallText(
                          text: "Tap to upload a new profile picture."),
                      trailing: _profileController.user.profilePicUrl != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                  _profileController.user.profilePicUrl!),
                            )
                          : CircleAvatar(
                              backgroundColor: VvcColors.mainLightColor,
                              child: Icon(
                                CupertinoIcons.person,
                                color: VvcColors.bgColor,
                              ),
                            ),
                    ),
                  )),

              Obx(() => VvcCard(
                    onPressed: () {
                      VvcBottomSheet.showBottomSheet(child: _changeEmailForm());
                    },
                    child: ListTile(
                      title: Text("Email"),
                      subtitle: VvcSmallText(
                          text: "Tap to change your email address."),
                      trailing:
                          VvcSmallText(text: _profileController.user.email),
                    ),
                  )),

              VvcCard(
                onLongPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: _profileController.user.id),
                  );
                  VvcSnackBar.showSnackBar(
                      title: "Clipboard",
                      message: "ID is copied to clipboard!");
                },
                child: ListTile(
                  title: Text("Unique ID"),
                  subtitle: VvcSmallText(text: "Long press to copy."),
                  trailing: VvcSmallText(text: _profileController.user.id),
                ),
              ),

              for (var i = 0;
                  i < _authController.getCurrentUser!.providerData.length;
                  i++)
                VvcCard(
                  child: ListTile(
                    title:
                        _authController.getCurrentUser!.providerData.length == 1
                            ? Text("Created by")
                            : Text("Account Provider ${i + 1}"),
                    trailing: VvcSmallText(
                        text: _authController
                            .getCurrentUser!.providerData[i].providerId),
                  ),
                ),

              VvcCard(
                child: ListTile(
                  title: Text("Created at"),
                  trailing: VvcSmallText(
                      text: _authController
                          .getCurrentUser!.metadata.creationTime
                          .toString()
                          .substring(0, 19)),
                ),
              ),

              VvcCard(
                child: ListTile(
                  title: Text("Last Logged in at"),
                  trailing: VvcSmallText(
                      text: _authController
                          .getCurrentUser!.metadata.lastSignInTime
                          .toString()
                          .substring(0, 19)),
                ),
              ),

              //!Account Actions

              VvcMenuTitleCard(child: VvcSubHeading(text: "Account Actions")),

              _authController.getCurrentUser != null
                  ? Obx(() => VvcCard(
                        onPressed: () {
                          if (!_authController.getCurrentUser!.emailVerified) {
                            _profileController.verifyUserEmail();
                          } else
                            VvcSnackBar.showSnackBar(
                                title: "Verification!",
                                message: "Your account is already verified!");
                        },
                        child: ListTile(
                          title: _authController.getCurrentUser!.emailVerified
                              ? Text("Account is Verified!")
                              : Text("Unverified Account!"),
                          subtitle:
                              _authController.getCurrentUser!.emailVerified
                                  ? null
                                  : Text("Verify Your accout now!"),
                          trailing:
                              _authController.getCurrentUser!.emailVerified
                                  ? Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      CupertinoIcons.xmark_octagon_fill,
                                      color: Colors.red,
                                    ),
                        ),
                      ))
                  : Container(),

              for (var i = 0;
                  i < _authController.getCurrentUser!.providerData.length;
                  i++)
                _authController.getCurrentUser!.providerData[i].providerId ==
                        "password"
                    ? VvcCard(
                        onPressed: () {
                          VvcBottomSheet.showBottomSheet(
                              child: _changePasswordForm());
                        },
                        child: ListTile(
                          title: Text("Change Password"),
                          trailing: Icon(FontAwesomeIcons.keycdn),
                        ),
                      )
                    : Container(),
              VvcCard(
                onPressed: () async {
                  await Share.share(
                      "Hey check out my account in VVC.\nMy id is : ${_profileController.user.id}");
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

              //!About App

              VvcMenuTitleCard(child: VvcSubHeading(text: "About App")),

              VvcCard(
                onPressed: () {
                  //TODO: Add about us
                  VvcBottomSheet.showBottomSheet(
                    name: "Privacy Policy Bottom Sheet",
                    child: Markdown(data: PrivacyPolicy.text),
                  );
                },
                child: ListTile(
                  title: Text("About VVC"),
                  trailing: Icon(Icons.business),
                ),
              ),
              VvcCard(
                onPressed: () {
                  VvcBottomSheet.showBottomSheet(
                    name: "Terms And Condition Bottom Sheet",
                    child: Markdown(data: TermsAndCondition.text),
                  );
                },
                child: ListTile(
                  title: Text("Privacy Policy"),
                  trailing: Icon(Icons.security),
                ),
              ),
              VvcCard(
                onPressed: () {
                  VvcBottomSheet.showBottomSheet(
                    name: "Terms And Condition Bottom Sheet",
                    child: Markdown(data: TermsAndCondition.text),
                  );
                },
                child: ListTile(
                  title: Text("Terms And Conditions"),
                  trailing: Icon(Icons.gavel),
                ),
              ),

              //!Danger Zone
              VvcMenuTitleCard(child: VvcSubHeading(text: "See ya!")),

              VvcCard(
                onPressed: () {
                  VvcDialog.showConfirmDialog(
                    title: "Are you sure to log out?",
                    onConfirmPressed: () async {
                      print("Helllo");
                      await Get.find<AuthController>().logOut();
                    },
                  );
                },
                child: ListTile(
                  title: Text("Log Out"),
                  trailing: Icon(Icons.logout),
                ),
              ),

              //!Versions
              VvcStyle.defaultVerticalSpacer,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VvcSmallText(
                      text:
                          "Copyright © ${_profileController.appName.toUpperCase()}, ${DateTime.now().year}"),
                  SizedBox(
                    height: 4,
                  ),
                  VvcSmallText(
                      text:
                          "Version: ${_profileController.version}+${_profileController.buildNumber}"),
                ],
              ),
              VvcStyle.defaultVerticalSpacer,
            ],
          ),
        ),
      ),
    );
  }

  Form _changeEmailForm() {
    return Form(
      key: _profileController.emailFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            VvcStyle.defaultVerticalSpacer,
            VvcSubHeading(text: "Change Your Email!"),
            VvcStyle.defaultVerticalSpacer,
            Obx(() => VvcTextFormField(
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _profileController.currentPasswordObscure.value =
                          !_profileController.currentPasswordObscure.value;
                    },
                    icon: Icon(
                      _profileController.currentPasswordObscure.value
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: VvcColors.primaryColor1,
                    ),
                  ),
                  obscure: _profileController.currentPasswordObscure.value,
                  controller:
                      _profileController.currentPasswordTextEditingController,
                  label: "Current Password",
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "Password is at least 6 characters long!";
                    }
                  },
                )),
            VvcStyle.defaultVerticalSpacer,
            VvcTextFormField(
              textInputType: TextInputType.emailAddress,
              controller: _profileController.emailTextEditingController,
              label: "New Email",
              onValidate: (value) {
                if (!GetUtils.isEmail(value!)) {
                  return "Invalid Email!";
                }
              },
            ),
            VvcStyle.defaultVerticalSpacer,
            VvcElevatedButton.text(
              label: "Change Email",
              onPressed: () {
                if (_profileController.emailFormKey.currentState!.validate()) {
                  Get.back();

                  _profileController.updateUserEmail();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Form _changePasswordForm() {
    return Form(
      key: _profileController.passwordFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            VvcStyle.defaultVerticalSpacer,
            VvcSubHeading(text: "Change Your Password!"),
            VvcStyle.defaultVerticalSpacer,
            Obx(() => VvcTextFormField(
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _profileController.currentPasswordObscure.value =
                          !_profileController.currentPasswordObscure.value;
                    },
                    icon: Icon(
                      _profileController.currentPasswordObscure.value
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: VvcColors.primaryColor1,
                    ),
                  ),
                  obscure: _profileController.currentPasswordObscure.value,
                  controller:
                      _profileController.currentPasswordTextEditingController,
                  label: "Current Password",
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "Password is at least 6 characters long!";
                    }
                  },
                )),
            VvcStyle.defaultVerticalSpacer,
            Obx(() => VvcTextFormField(
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _profileController.newPasswordObscure.value =
                          !_profileController.newPasswordObscure.value;
                    },
                    icon: Icon(
                      _profileController.newPasswordObscure.value
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: VvcColors.primaryColor1,
                    ),
                  ),
                  obscure: _profileController.newPasswordObscure.value,
                  controller:
                      _profileController.newPasswordTextEditingController,
                  label: "New Password",
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "Password is at least 6 characters long!";
                    }
                  },
                )),
            VvcStyle.defaultVerticalSpacer,
            Obx(() => VvcTextFormField(
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _profileController.confirmPasswordObscure.value =
                          !_profileController.confirmPasswordObscure.value;
                    },
                    icon: Icon(
                      _profileController.confirmPasswordObscure.value
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: VvcColors.primaryColor1,
                    ),
                  ),
                  obscure: _profileController.confirmPasswordObscure.value,
                  controller: _profileController
                      .newConfirmPasswordTextEditingController,
                  label: "Confirm New Password",
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "Password is at least 6 characters long!";
                    } else if (_profileController
                            .newPasswordTextEditingController.text !=
                        _profileController
                            .newConfirmPasswordTextEditingController.text) {
                      return "Passwords don't match!";
                    }
                  },
                )),
            VvcStyle.defaultVerticalSpacer,
            VvcElevatedButton.text(
              label: "Change Password",
              onPressed: () {
                if (_profileController.passwordFormKey.currentState!
                    .validate()) {
                  Get.back();

                  _profileController.updateUserPassword();
                }
              },
            )
          ],
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
            subtitle: VvcSmallText(text: "Tap to change your name."),
            trailing:
                VvcSmallText(text: _profileController.user.name ?? "No name"),
          ),
        ));
  }
}
