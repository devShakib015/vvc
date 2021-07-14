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

              VvcMenuTitleCard(child: VvcSubHeading(text: "my_account".tr)),

              //!Name Card

              VvcCard(
                onPressed: () {
                  VvcBottomSheet.showBottomSheet(
                    child: _changeNameForm(),
                  );
                },
                child: Obx(() => ListTile(
                      title: Text("settings_name".tr),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child:
                                VvcSmallText(text: "settings_name_subtitle".tr),
                          ),
                          VvcStyle.defaultHorizontalSpacer,
                          VvcSmallText(
                              text: _settingsController.user.name ??
                                  "settings_no_name".tr)
                        ],
                      ),
                    )),
              ),

              //!Profile Picture Card

              VvcCard(
                onPressed: _settingsController.updateUserProfilePic,
                child: Obx(() => ListTile(
                      title: Text("settings_profile_picture".tr),
                      subtitle: VvcSmallText(
                          text: "settings_profile_picture_subtitle".tr),
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
                      title: Text("settings_email".tr),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: VvcSmallText(
                                text: "settings_email_subtitle".tr),
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
                      message: "settings_user_name_copy".tr);
                },
                onPressed: () {
                  VvcBottomSheet.showBottomSheet(child: _changeUserNameForm());
                },
                child: Obx(() => ListTile(
                      title: Text("settings_user_name".tr),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: VvcSmallText(
                                  text: "settings_user_name_subtitle".tr)),
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
                            ? Text("settings_created_by".tr)
                            : Text("settings_provide_by".tr + "${i + 1}"),
                    trailing: VvcSmallText(
                        text: _authController
                            .getCurrentUser!.providerData[i].providerId),
                  ),
                ),

              //!Created AT Card

              VvcCard(
                child: ListTile(
                  title: Text("settings_created_at".tr),
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
                  title: Text("settings_last_logged_in".tr),
                  trailing: VvcSmallText(
                      text: _authController
                          .getCurrentUser!.metadata.lastSignInTime
                          .toString()
                          .substring(0, 19)),
                ),
              ),

              //!Account Actions

              VvcMenuTitleCard(
                  child: VvcSubHeading(text: "settings_account_actions".tr)),

              //!Account Verification Card

              _authController.getCurrentUser != null
                  ? Obx(() => VvcCard(
                        onPressed: () {
                          if (!_authController.getCurrentUser!.emailVerified) {
                            _settingsController.verifyUserEmail();
                          } else
                            VvcSnackBar.showSnackBar(
                                title: "settings_verification_title".tr,
                                message: "settings_already_verified".tr);
                        },
                        child: ListTile(
                          title: _authController.getCurrentUser!.emailVerified
                              ? Text("settings_account_verified".tr)
                              : Text("settings_account_not_verified".tr),
                          subtitle: _authController
                                  .getCurrentUser!.emailVerified
                              ? null
                              : VvcSmallText(
                                  text:
                                      "settings_account_verified_subtitle".tr),
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
                          title: Text("settings_change_password".tr),
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
                  title: Text("settings_share_account".tr),
                  trailing: Icon(CupertinoIcons.share_up),
                ),
              ),

              //!App Actions

              VvcMenuTitleCard(
                  child: VvcSubHeading(text: "settings_app_actions".tr)),

              //!Onboarding Card

              Obx(() => VvcCard(
                    onPressed: () {
                      Get.find<StorageController>().updateOnBoardingStorage(
                          !Get.find<StorageController>().isOnBoardingShown);
                    },
                    child: Get.find<StorageController>().isOnBoardingShown
                        ? ListTile(
                            title: Text("settings_on_onboarding".tr),
                            trailing: Icon(Icons.toggle_off),
                          )
                        : ListTile(
                            title: Text("settings_off_onboarding".tr),
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
                        VvcSubHeading(text: "settings_select_language".tr),
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
                  title: Text("settings_language".tr),
                  trailing: Icon(Icons.translate_rounded),
                ),
              ),

              //!About App

              VvcMenuTitleCard(
                  child: VvcSubHeading(text: "settings_about_app".tr)),

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
                  title: Text("settings_about_vvc".tr),
                  trailing: Icon(Icons.business),
                ),
              ),

              //!Privacy Policy Card

              VvcCard(
                onPressed: () {
                  VvcBottomSheet.showBottomSheet(
                    name: "Privacy Bottom Sheet",
                    child: Markdown(data: TermsAndCondition.text),
                  );
                },
                child: ListTile(
                  title: Text("settings_privacy".tr),
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
                  title: Text("settings_terms".tr),
                  trailing: Icon(Icons.gavel),
                ),
              ),

              //!Danger Zone
              VvcMenuTitleCard(
                  child: VvcSubHeading(text: "settings_see_ya".tr)),

              VvcCard(
                onPressed: () {
                  VvcDialog.showConfirmDialog(
                    title: "settings_logout_confirmation".tr,
                    onConfirmPressed: () async {
                      await Get.find<AuthController>().logOut();
                    },
                  );
                },
                child: ListTile(
                  title: Text("settings_logout".tr),
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
          VvcSubHeading(text: "settings_name_change_title".tr),
          VvcStyle.defaultVerticalSpacer,
          VvcTextFormField(
            controller: _settingsController.nameTextEditingController,
            label: "settings_name_change_new_name".tr,
            onValidate: (value) {
              if (value!.length < 3) {
                return "settings_name_change_new_name_error".tr;
              }
            },
          ),
          VvcStyle.defaultVerticalSpacer,
          VvcElevatedButton.text(
            label: "settings_name_change".tr,
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
            VvcSubHeading(text: "settings_email_change_title".tr),
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
                  label: "settings_email_change_current_password".tr,
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "settings_email_change_current_password_error".tr;
                    }
                  },
                )),
            VvcStyle.defaultVerticalSpacer,
            VvcTextFormField(
              textInputType: TextInputType.emailAddress,
              controller: _settingsController.emailTextEditingController,
              label: "settings_email_change_new_email".tr,
              onValidate: (value) {
                if (!GetUtils.isEmail(value!)) {
                  return "settings_email_change_new_email_error".tr;
                }
              },
            ),
            VvcStyle.defaultVerticalSpacer,
            VvcElevatedButton.text(
              label: "settings_email_change".tr,
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
            VvcSubHeading(text: "settings_username_change_title".tr),
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
                  label: "settings_username_change_current_password".tr,
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "settings_username_change_current_password_error"
                          .tr;
                    }
                  },
                )),
            VvcStyle.defaultVerticalSpacer,
            VvcTextFormField(
              textInputType: TextInputType.text,
              controller: _settingsController.userNameTextEditingController,
              label: "settings_username_change_new_username".tr,
              onValidate: (value) {
                if (value!.length < 5) {
                  return "settings_username_change_new_username_error".tr;
                }
              },
            ),
            VvcStyle.defaultVerticalSpacer,
            VvcElevatedButton.text(
              label: "settings_username_change".tr,
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
            VvcSubHeading(text: "settings_password_change_title".tr),
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
                  label: "settings_password_change_current_password".tr,
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "settings_password_change_current_password_error"
                          .tr;
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
                  label: "settings_password_change_new_password".tr,
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "settings_password_change_new_password_error".tr;
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
                  label: "settings_password_change_confirm_password".tr,
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return "settings_password_change_confirm_password_error"
                          .tr;
                    } else if (_settingsController
                            .newPasswordTextEditingController.text !=
                        _settingsController
                            .newConfirmPasswordTextEditingController.text) {
                      return "settings_password_change_dont_match".tr;
                    }
                  },
                )),
            VvcStyle.defaultVerticalSpacer,
            VvcElevatedButton.text(
              label: "settings_password_change".tr,
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
