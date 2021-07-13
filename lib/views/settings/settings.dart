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
import 'package:vvc/controllers/settings_controller/settings_controller.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/utils/privacy_policy.dart';
import 'package:vvc/utils/terms_and_conditions.dart';
import 'package:vvc/utils/vvc_multi_language.dart';
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

  final SettingsController _settingsController = Get.find<SettingsController>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: VvcAppBarTitle(text: "settings".tr),
        actions: [
          IconButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: _settingsController.appName,
                applicationIcon: Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(VvcImages.logo)),
                applicationLegalese: "devShakib",
                applicationVersion: _settingsController.version,
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

              //!Name Card

              VvcCard(
                onPressed: () {
                  VvcBottomSheet.showBottomSheet(
                    child: _changeNameForm(),
                  );
                },
                child: Obx(() => ListTile(
                      title: Text("Name"),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: VvcSmallText(text: "Tap to change name."),
                          ),
                          VvcStyle.defaultHorizontalSpacer,
                          VvcSmallText(
                              text: _settingsController.user.name ?? "No name")
                        ],
                      ),
                    )),
              ),

              //!Profile Picture Card

              VvcCard(
                onPressed: _settingsController.updateUserProfilePic,
                child: Obx(() => ListTile(
                      title: Text("Profile Picture"),
                      subtitle: VvcSmallText(
                          text: "Tap to upload a new profile picture."),
                      trailing: _settingsController.user.profilePicUrl != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                  _settingsController.user.profilePicUrl!),
                            )
                          : CircleAvatar(
                              backgroundColor: VvcColors.mainLightColor,
                              child: Icon(
                                CupertinoIcons.person,
                                color: VvcColors.bgColor,
                              ),
                            ),
                    )),
              ),

              //!Email Card

              VvcCard(
                onPressed: () {
                  VvcBottomSheet.showBottomSheet(child: _changeEmailForm());
                },
                child: Obx(() => ListTile(
                      title: Text("Email"),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: VvcSmallText(text: "Tap to change email."),
                          ),
                          VvcStyle.defaultHorizontalSpacer,
                          VvcSmallText(text: _settingsController.user.email),
                        ],
                      ),
                    )),
              ),

              //!User Name Card

              VvcCard(
                onLongPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: _settingsController.user.id),
                  );
                  VvcSnackBar.showSnackBar(
                      title: "Clipboard",
                      message: "ID is copied to clipboard!");
                },
                onPressed: () {
                  VvcBottomSheet.showBottomSheet(child: _changeUserNameForm());
                },
                child: Obx(() => ListTile(
                      title: Text("User Name"),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: VvcSmallText(text: "Long press to copy.")),
                          VvcStyle.defaultHorizontalSpacer,
                          VvcSmallText(text: _settingsController.user.userName),
                        ],
                      ),
                    )),
              ),

              //!Created BY Card

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

              //!Created AT Card

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

              //!Last Logged In Card

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

              //!Account Verification Card

              _authController.getCurrentUser != null
                  ? Obx(() => VvcCard(
                        onPressed: () {
                          if (!_authController.getCurrentUser!.emailVerified) {
                            _settingsController.verifyUserEmail();
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

              //!Change Password Card

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

              //!Share Account Card

              VvcCard(
                onPressed: () async {
                  await Share.share(
                      "Hey check out my account in VVC.\nMy username is : ${_settingsController.user.userName}");
                },
                child: ListTile(
                  title: Text("Share Account"),
                  trailing: Icon(CupertinoIcons.share_up),
                ),
              ),

              //!App Actions

              VvcMenuTitleCard(child: VvcSubHeading(text: "App Actions")),

              //!Onboarding Card

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

              //!Language Card

              VvcCard(
                onPressed: () {
                  VvcBottomSheet.showBottomSheet(
                      child: Container(
                    child: Column(
                      children: [
                        VvcSubHeading(text: "Select Language!"),
                        Expanded(
                          child: ListView(
                            children: vvcLanguages.map((language) {
                              return Obx(() => ListTile(
                                    title: Text(language.name),
                                    trailing: Checkbox(
                                      onChanged: (value) {
                                        _settingsController
                                                .currentLangIndex.value =
                                            vvcLanguages.indexOf(language);
                                        Get.updateLocale(language.locale);
                                        _settingsController
                                            .updateLanguageIndexStorage(
                                                vvcLanguages.indexOf(language));
                                      },
                                      value: _settingsController
                                              .currentLangIndex.value ==
                                          vvcLanguages.indexOf(language),
                                    ),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ));
                },
                child: ListTile(
                  title: Text("Change Language"),
                  trailing: Icon(Icons.translate_rounded),
                ),
              ),

              //!About App

              VvcMenuTitleCard(child: VvcSubHeading(text: "About App")),

              //!About card

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

              //!Privacy Policy Card

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

              //!Terms And Condition Card

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
                          "Copyright © ${_settingsController.appName.toUpperCase()}, ${DateTime.now().year}"),
                  SizedBox(
                    height: 4,
                  ),
                  VvcSmallText(
                      text:
                          "Version: ${_settingsController.version}+${_settingsController.buildNumber}"),
                ],
              ),
              VvcStyle.defaultVerticalSpacer,
            ],
          ),
        ),
      ),
    );
  }

  Form _changeNameForm() {
    return Form(
      key: _settingsController.nameFormKey,
      child: Column(
        children: [
          VvcStyle.defaultVerticalSpacer,
          VvcSubHeading(
              text:
                  "Change your name. This will change the account name, Not your card names!"),
          VvcStyle.defaultVerticalSpacer,
          VvcTextFormField(
            controller: _settingsController.nameTextEditingController,
            label: "New Name",
            onValidate: (value) {
              if (value!.length < 3) {
                return "Name must be at least 3 characters long";
              }
            },
          ),
          VvcStyle.defaultVerticalSpacer,
          VvcElevatedButton.text(
            label: "Change Name",
            onPressed: () {
              if (_settingsController.nameFormKey.currentState!.validate()) {
                Get.back();

                _settingsController.updateUserDefaultName(
                  name:
                      _settingsController.nameTextEditingController.text.trim(),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Form _changeEmailForm() {
    return Form(
      key: _settingsController.emailFormKey,
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
                      _settingsController.currentPasswordObscure.value =
                          !_settingsController.currentPasswordObscure.value;
                    },
                    icon: Icon(
                      _settingsController.currentPasswordObscure.value
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: VvcColors.primaryColor1,
                    ),
                  ),
                  obscure: _settingsController.currentPasswordObscure.value,
                  controller:
                      _settingsController.currentPasswordTextEditingController,
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
              controller: _settingsController.emailTextEditingController,
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
                if (_settingsController.emailFormKey.currentState!.validate()) {
                  Get.back();

                  _settingsController.updateUserEmail();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Form _changeUserNameForm() {
    return Form(
      key: _settingsController.userNameFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            VvcStyle.defaultVerticalSpacer,
            VvcSubHeading(text: "Change Your username!"),
            VvcStyle.defaultVerticalSpacer,
            Obx(() => VvcTextFormField(
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _settingsController.currentPasswordObscure.value =
                          !_settingsController.currentPasswordObscure.value;
                    },
                    icon: Icon(
                      _settingsController.currentPasswordObscure.value
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: VvcColors.primaryColor1,
                    ),
                  ),
                  obscure: _settingsController.currentPasswordObscure.value,
                  controller:
                      _settingsController.currentPasswordTextEditingController,
                  label: "Current Password",
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "Password is at least 6 characters long!";
                    }
                  },
                )),
            VvcStyle.defaultVerticalSpacer,
            VvcTextFormField(
              textInputType: TextInputType.text,
              controller: _settingsController.userNameTextEditingController,
              label: "New Username",
              onValidate: (value) {
                if (value!.length < 5) {
                  return "User name is at least 5 characters long!";
                }
              },
            ),
            VvcStyle.defaultVerticalSpacer,
            VvcElevatedButton.text(
              label: "Change Username",
              onPressed: () {
                if (_settingsController.userNameFormKey.currentState!
                    .validate()) {
                  Get.back();

                  _settingsController.updateUserName();
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
      key: _settingsController.passwordFormKey,
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
                      _settingsController.currentPasswordObscure.value =
                          !_settingsController.currentPasswordObscure.value;
                    },
                    icon: Icon(
                      _settingsController.currentPasswordObscure.value
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: VvcColors.primaryColor1,
                    ),
                  ),
                  obscure: _settingsController.currentPasswordObscure.value,
                  controller:
                      _settingsController.currentPasswordTextEditingController,
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
                      _settingsController.newPasswordObscure.value =
                          !_settingsController.newPasswordObscure.value;
                    },
                    icon: Icon(
                      _settingsController.newPasswordObscure.value
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: VvcColors.primaryColor1,
                    ),
                  ),
                  obscure: _settingsController.newPasswordObscure.value,
                  controller:
                      _settingsController.newPasswordTextEditingController,
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
                      _settingsController.confirmPasswordObscure.value =
                          !_settingsController.confirmPasswordObscure.value;
                    },
                    icon: Icon(
                      _settingsController.confirmPasswordObscure.value
                          ? CupertinoIcons.eye_solid
                          : CupertinoIcons.eye_slash_fill,
                      color: VvcColors.primaryColor1,
                    ),
                  ),
                  obscure: _settingsController.confirmPasswordObscure.value,
                  controller: _settingsController
                      .newConfirmPasswordTextEditingController,
                  label: "Confirm New Password",
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "Password is at least 6 characters long!";
                    } else if (_settingsController
                            .newPasswordTextEditingController.text !=
                        _settingsController
                            .newConfirmPasswordTextEditingController.text) {
                      return "Passwords don't match!";
                    }
                  },
                )),
            VvcStyle.defaultVerticalSpacer,
            VvcElevatedButton.text(
              label: "Change Password",
              onPressed: () {
                if (_settingsController.passwordFormKey.currentState!
                    .validate()) {
                  Get.back();

                  _settingsController.updateUserPassword();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
