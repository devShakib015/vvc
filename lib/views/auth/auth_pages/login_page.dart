import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/image_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/controllers/auth_controller/auth_page_controller.dart';
import 'package:vvc/utils/main_page.dart';
import 'package:vvc/widgets/vvc_elevated_button.dart';
import 'package:vvc/widgets/vvc_heading.dart';
import 'package:vvc/widgets/vvc_sub_heading.dart';
import 'package:vvc/widgets/vvc_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController;
  final AuthPageController _authPageController;

  LoginPage({
    required authController,
    required authPageController,
  })  : this._authController = authController,
        this._authPageController = authPageController;

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
            child: Center(
              child: Form(
                key: _authPageController.loginFormKey,
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
                      VvcTextFormField(
                        controller: _authPageController.loginEmailController,
                        label: "Email",
                        icon: CupertinoIcons.mail,
                        textInputType: TextInputType.emailAddress,
                        onValidate: (text) {
                          if (!GetUtils.isEmail(text!)) {
                            return "Invalid Email!";
                          }
                        },
                      ),
                      VvcStyle.defaultVerticalSpacer,
                      Obx(() => VvcTextFormField(
                            controller:
                                _authPageController.loginPasswordController,
                            textInputType: TextInputType.visiblePassword,
                            label: "Password",
                            obscure:
                                _authPageController.loginPasswordObscure.value,
                            icon: FontAwesomeIcons.keycdn,
                            suffixIcon: IconButton(
                              onPressed: () {
                                _authPageController.loginPasswordObscure.value =
                                    !_authPageController
                                        .loginPasswordObscure.value;
                              },
                              icon: Icon(
                                _authPageController.loginPasswordObscure.value
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
                          )),
                      VvcStyle.defaultVerticalSpacer,
                      VvcStyle.defaultVerticalSpacer,
                      VvcElevatedButton.text(
                          label: "Login",
                          onPressed: () async {
                            //todo: Login
                            if (_authPageController.loginFormKey.currentState!
                                .validate()) {
                              await _authController.login();
                              _authPageController.clearFields();
                              Get.to(() => MainPage());
                            } else {
                              Get.snackbar(
                                "Login Error",
                                "Please verify the fields",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          }),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VvcSubHeading(text: "Forgot Password? "),
                          GestureDetector(
                            onTap: () {
                              //todo: Reset Password
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: VvcSubHeading(text: "Reset Here!"),
                            ),
                          )
                        ],
                      ),

                      Divider(
                        color: VvcColors.primaryColor2,
                        height: 2,
                        thickness: 1,
                      ),
                      VvcStyle.defaultVerticalSpacer,
                      VvcSubHeading(text: "Or Continue With,"),
                      VvcStyle.defaultVerticalSpacer,
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            VvcElevatedButton.icon(
                              tooltip: "Facebook Login",
                              icon: Icon(FontAwesomeIcons.facebookF),
                              onPressed: () {
                                //todo: Login With facebook
                              },
                            ),
                            VvcStyle.defaultHorizontalSpacer,
                            VvcElevatedButton.icon(
                              tooltip: "Google Login",
                              icon: Icon(FontAwesomeIcons.google),
                              onPressed: () {
                                //todo: Login With Google
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VvcSubHeading(text: "New User?"),
                          VvcStyle.defaultHorizontalSpacer,
                          GestureDetector(
                            onTap: () {
                              _authPageController.clearFields();
                              _authPageController.pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child:
                                  VvcSubHeading(text: "Sign Up using Email!"),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
