import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/image_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/utils/privacy_policy.dart';
import 'package:vvc/utils/terms_and_conditions.dart';
import 'package:vvc/widgets/vvc_bottom_sheet.dart';
import 'package:vvc/widgets/vvc_elevated_button.dart';
import 'package:vvc/widgets/vvc_heading.dart';
import 'package:vvc/widgets/vvc_small_text.dart';

import 'package:vvc/widgets/vvc_sub_heading.dart';
import 'package:vvc/widgets/vvc_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatelessWidget {
  final AuthController _authController;

  SignUpPage({
    required authPageController,
  }) : this._authController = authPageController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.transparent,
          height: VvcStyle.defaultScreenHeight,
          child: SingleChildScrollView(
            child: _signUpFormSection(),
          ),
        ),
      ),
    );
  }

  Center _signUpFormSection() {
    return Center(
      child: Form(
        key: _authController.signUpFormKey,
        child: Padding(
          padding: VvcStyle.defaultSidePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VvcStyle.defaultVerticalSpacer,

              //Logo
              Container(
                width: VvcStyle.halfScreenWidth,
                child: Image.asset(VvcImages.logo),
              ),
              VvcStyle.defaultVerticalSpacer,

              VvcHeading(text: "signUp".tr),
              VvcStyle.defaultVerticalSpacer,
              _emailTextfieldSection(),
              VvcStyle.defaultVerticalSpacer,
              _userNameTextfieldSection(),
              VvcStyle.defaultVerticalSpacer,

              _passwordTextfieldSection(),
              VvcStyle.defaultVerticalSpacer,
              _confirmPassTextfieldSection(),

              _signUpCheckBoxes(),
              VvcStyle.defaultVerticalSpacer,

              VvcElevatedButton.text(
                label: "signUp".tr,
                onPressed: _authController.onPressedSignUp,
              ),

              _loginSection(),
            ],
          ),
        ),
      ),
    );
  }

  VvcTextFormField _emailTextfieldSection() {
    return VvcTextFormField(
      controller: _authController.signUpEmailController,
      label: "signUp_email".tr,
      icon: CupertinoIcons.mail,
      textInputType: TextInputType.emailAddress,
      onValidate: (text) {
        if (!GetUtils.isEmail(text!)) {
          return "signUp_email_error".tr;
        }
      },
    );
  }

  VvcTextFormField _userNameTextfieldSection() {
    return VvcTextFormField(
      controller: _authController.signUpUserNameController,
      label: "signUp_username".tr,
      icon: Icons.perm_identity,
      textInputType: TextInputType.emailAddress,
      onValidate: (text) {
        if (text!.length < 5) {
          return "signUp_username_error".tr;
        }
      },
    );
  }

  Obx _passwordTextfieldSection() {
    return Obx(() => VvcTextFormField(
          controller: _authController.signUpPasswordController,
          textInputType: TextInputType.visiblePassword,
          label: "signUp_password".tr,
          obscure: _authController.signUpPasswordObscure.value,
          icon: FontAwesomeIcons.keycdn,
          suffixIcon: IconButton(
            onPressed: () {
              _authController.signUpPasswordObscure.value =
                  !_authController.signUpPasswordObscure.value;
            },
            icon: Icon(
              _authController.signUpPasswordObscure.value
                  ? CupertinoIcons.eye_solid
                  : CupertinoIcons.eye_slash_fill,
              color: VvcColors.primaryColor1,
            ),
          ),
          onValidate: (text) {
            if (text!.length < 6) {
              return "signUp_password_error".tr;
            }
          },
        ));
  }

  Obx _confirmPassTextfieldSection() {
    return Obx(() => VvcTextFormField(
          controller: _authController.signUpConfirmPasswordController,
          textInputType: TextInputType.visiblePassword,
          label: "signUp_confirm_password".tr,
          obscure: _authController.signUpConfirmPasswordObscure.value,
          icon: FontAwesomeIcons.keycdn,
          suffixIcon: IconButton(
            onPressed: () {
              _authController.signUpConfirmPasswordObscure.value =
                  !_authController.signUpConfirmPasswordObscure.value;
            },
            icon: Icon(
              _authController.signUpConfirmPasswordObscure.value
                  ? CupertinoIcons.eye_solid
                  : CupertinoIcons.eye_slash_fill,
              color: VvcColors.primaryColor1,
            ),
          ),
          onValidate: (text) {
            if (text!.length < 6) {
              return "signUp_password_error".tr;
            } else if (text != _authController.signUpPasswordController.text) {
              return "signUp_password_dont_match".tr;
            }
          },
        ));
  }

  Row _loginSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        VvcSubHeading(text: "signUp_already_user".tr),
        GestureDetector(
          onTap: _authController.goToLoginPage,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: VvcSubHeading(text: "signUp_go_to_login".tr),
          ),
        )
      ],
    );
  }

  Obx _signUpCheckBoxes() {
    return Obx(
      () => Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: _authController.getRememberMe,
                onChanged: (value) {
                  _authController.setRememberMe = value!;
                },
              ),
              VvcSmallText(text: "signUp_remember".tr)
            ],
          ),
          _privacyAndTermsSection()
        ],
      ),
    );
  }

  Row _privacyAndTermsSection() {
    return Row(
      children: [
        Checkbox(
          value: _authController.isAcceptedPrivacyAndTerms.value,
          onChanged: (value) {
            _authController.isAcceptedPrivacyAndTerms.value = value!;
          },
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VvcSmallText(
                text: "privacy_terms_sentence".tr,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      VvcBottomSheet.showBottomSheet(
                        name: "Privacy Policy Bottom Sheet",
                        child: Markdown(data: PrivacyPolicy.text),
                      );
                    },
                    child: VvcSmallText(
                      text: "privacy_policy".tr,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                  VvcSmallText(text: "and".tr),
                  GestureDetector(
                    onTap: () {
                      VvcBottomSheet.showBottomSheet(
                        name: "Terms And Condition Bottom Sheet",
                        child: Markdown(data: TermsAndCondition.text),
                      );
                    },
                    child: VvcSmallText(
                      text: "terms_and_conditions".tr,
                      textDecoration: TextDecoration.underline,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
