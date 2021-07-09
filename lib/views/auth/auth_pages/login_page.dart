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
              //Logo
              Container(
                width: VvcStyle.halfScreenWidth,
                child: Image.asset(VvcImages.logo),
              ),

              VvcHeading(text: "Login"),
              VvcStyle.defaultVerticalSpacer,
              _emailTextFieldSection(),
              VvcStyle.defaultVerticalSpacer,
              _passwordTextFieldSection(),
              VvcStyle.defaultVerticalSpacer,
              VvcStyle.defaultVerticalSpacer,
              VvcElevatedButton.text(
                label: "Login",
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
              VvcSubHeading(text: "Or Continue With,"),
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
          label: "Password",
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
              color: VvcColors.primaryColor2,
            ),
          ),
          onValidate: (text) {
            if (text!.length < 6) {
              return "Password Must Be At Least 6 Characters";
            }
          },
        ));
  }

  VvcTextFormField _emailTextFieldSection() {
    return VvcTextFormField(
      controller: _authController.loginEmailController,
      label: "Email",
      icon: CupertinoIcons.mail,
      textInputType: TextInputType.emailAddress,
      onTap: _authController.loadSavedLoginInfo,
      onValidate: (text) {
        if (!GetUtils.isEmail(text!)) {
          return "Invalid Email!";
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
        VvcSmallText(text: "Remember Me!"),
      ],
    );
  }

  Row _signUpSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        VvcSubHeading(text: "New User?"),
        VvcStyle.defaultHorizontalSpacer,
        GestureDetector(
          onTap: _authController.goToSignUpPage,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: VvcSubHeading(
              text: "Sign Up using Email!",
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
            tooltip: "Facebook Login",
            icon: Icon(FontAwesomeIcons.facebookF),
            onPressed: () {
              //TODO: Login With facebook
            },
          ),
          VvcStyle.defaultHorizontalSpacer,
          VvcElevatedButton.icon(
            tooltip: "Google Login",
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
            child: Column(
              children: [
                VvcHeading(text: "Reset Password!"),
                VvcStyle.defaultVerticalSpacer,
                VvcStyle.defaultVerticalSpacer,
                VvcTextFormField(
                  controller: _authController.resetPasswordEmailController,
                  label: "Email Address",
                  icon: CupertinoIcons.mail,
                  textInputType: TextInputType.emailAddress,
                  onValidate: (text) {
                    if (!GetUtils.isEmail(text!)) {
                      return "Invalid Email!";
                    }
                  },
                ),
                VvcStyle.defaultVerticalSpacer,
                VvcStyle.defaultVerticalSpacer,
                VvcElevatedButton.text(
                  label: "Send Reset Request",
                  onPressed: _authController.onPressedResetPassword,
                ),
              ],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: VvcSmallText(
          text: "Forgot Password?",
          textDecoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
