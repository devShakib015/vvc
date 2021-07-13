import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/image_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/widgets/vvc_bottom_sheet.dart';
import 'package:vvc/widgets/vvc_elevated_button.dart';
import 'package:vvc/widgets/vvc_heading.dart';
import 'package:vvc/widgets/vvc_small_text.dart';
import 'package:vvc/widgets/vvc_sub_heading.dart';
import 'package:vvc/widgets/vvc_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController;

  LoginPage({
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
            child: _loginFormSection(),
          ),
        ),
      ),
    );
  }

  Center _loginFormSection() {
    return Center(
      child: Form(
        key: _authController.loginFormKey,
        child: Padding(
          padding: VvcStyle.defaultSidePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VvcStyle.defaultVerticalSpacer,
              VvcStyle.defaultVerticalSpacer,
              //Logo
              Container(
                width: VvcStyle.halfScreenWidth,
                child: Image.asset(VvcImages.logo),
              ),
              VvcStyle.defaultVerticalSpacer,

              VvcHeading(text: "login".tr),
              VvcStyle.defaultVerticalSpacer,
              _emailTextFieldSection(),
              VvcStyle.defaultVerticalSpacer,
              _passwordTextFieldSection(),
              VvcStyle.defaultVerticalSpacer,
              VvcStyle.defaultVerticalSpacer,
              VvcElevatedButton.text(
                label: "login".tr,
                onPressed: _authController.onPressedLogin,
              ),
              VvcStyle.defaultVerticalSpacer,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rememberMeSection(),
                  _resetPasswordSection(),
                ],
              ),

              VvcStyle.defaultDivider,

              VvcStyle.defaultVerticalSpacer,
              VvcSubHeading(text: "login_continue_with".tr),
              VvcStyle.defaultVerticalSpacer,
              _socialLoginSection(),
              _signUpSection(),
            ],
          ),
        ),
      ),
    );
  }

  Obx _passwordTextFieldSection() {
    return Obx(() => VvcTextFormField(
          controller: _authController.loginPasswordController,
          textInputType: TextInputType.visiblePassword,
          label: "login_password".tr,
          obscure: _authController.loginPasswordObscure.value,
          icon: FontAwesomeIcons.keycdn,
          suffixIcon: IconButton(
            onPressed: () {
              _authController.loginPasswordObscure.value =
                  !_authController.loginPasswordObscure.value;
            },
            icon: Icon(
              _authController.loginPasswordObscure.value
                  ? CupertinoIcons.eye_solid
                  : CupertinoIcons.eye_slash_fill,
              color: VvcColors.primaryColor1,
            ),
          ),
          onValidate: (text) {
            if (text!.length < 6) {
              return "login_password_error".tr;
            }
          },
        ));
  }

  VvcTextFormField _emailTextFieldSection() {
    return VvcTextFormField(
      controller: _authController.loginEmailController,
      label: "login_email".tr,
      icon: CupertinoIcons.mail,
      textInputType: TextInputType.emailAddress,
      onTap: _authController.loadSavedLoginInfo,
      onValidate: (text) {
        if (!GetUtils.isEmail(text!)) {
          return "login_email_error".tr;
        }
      },
    );
  }

  Row _rememberMeSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => Checkbox(
              value: _authController.getRememberMe,
              onChanged: (value) {
                _authController.setRememberMe = value!;
              },
            )),
        VvcSmallText(text: "login_remember".tr),
      ],
    );
  }

  Row _signUpSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        VvcSubHeading(text: "login_new_user".tr),
        VvcStyle.defaultHorizontalSpacer,
        GestureDetector(
          onTap: _authController.goToSignUpPage,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: VvcSubHeading(
              text: "login_go_to_sign_up".tr,
            ),
          ),
        )
      ],
    );
  }

  Container _socialLoginSection() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VvcElevatedButton.icon(
            tooltip: "login_facebook".tr,
            icon: Icon(FontAwesomeIcons.facebookF),
            onPressed: () {
              //TODO: Login With facebook
            },
          ),
          VvcStyle.defaultHorizontalSpacer,
          VvcElevatedButton.icon(
            tooltip: "login_google".tr,
            icon: Icon(FontAwesomeIcons.google),
            onPressed: _authController.loginUsingGoogle,
          ),
        ],
      ),
    );
  }

  GestureDetector _resetPasswordSection() {
    return GestureDetector(
      onTap: () {
        VvcBottomSheet.showBottomSheet(
          name: "Reset Password Bottom Sheet",
          child: Form(
            key: _authController.resetPassFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VvcSubHeading(text: "reset_password".tr),
                  VvcStyle.defaultVerticalSpacer,
                  VvcStyle.defaultVerticalSpacer,
                  VvcTextFormField(
                    controller: _authController.resetPasswordEmailController,
                    label: "login_email".tr,
                    icon: CupertinoIcons.mail,
                    textInputType: TextInputType.emailAddress,
                    onValidate: (text) {
                      if (!GetUtils.isEmail(text!)) {
                        return "login_email_error".tr;
                      }
                    },
                  ),
                  VvcStyle.defaultVerticalSpacer,
                  VvcStyle.defaultVerticalSpacer,
                  VvcElevatedButton.text(
                    label: "reset_password_send".tr,
                    onPressed: _authController.onPressedResetPassword,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: VvcSmallText(
          text: "login_forgot_password".tr,
          textDecoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
