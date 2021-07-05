import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/image_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/controllers/auth_controller/auth_page_controller.dart';
import 'package:vvc/widgets/vvc_elevated_button.dart';
import 'package:vvc/widgets/vvc_heading.dart';
import 'package:vvc/widgets/vvc_sub_heading.dart';
import 'package:vvc/widgets/vvc_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatelessWidget {
  final AuthController _authController;
  final AuthPageController _authPageController;

  SignUpPage({
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
                key: _authPageController.signUpFormKey,
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

                      VvcHeading(text: "Sign Up"),
                      VvcStyle.defaultVerticalSpacer,
                      VvcTextFormField(
                        controller: _authPageController.signUpEmailController,
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
                                _authPageController.signUpPasswordController,
                            textInputType: TextInputType.visiblePassword,
                            label: "Password",
                            obscure:
                                _authPageController.signUpPasswordObscure.value,
                            icon: FontAwesomeIcons.keycdn,
                            suffixIcon: IconButton(
                              onPressed: () {
                                _authPageController
                                        .signUpPasswordObscure.value =
                                    !_authPageController
                                        .signUpPasswordObscure.value;
                              },
                              icon: Icon(
                                _authPageController.signUpPasswordObscure.value
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
                      Obx(() => VvcTextFormField(
                            controller: _authPageController
                                .signUpConfirmPasswordController,
                            textInputType: TextInputType.visiblePassword,
                            label: "Confirm Password",
                            obscure: _authPageController
                                .signUpConfirmPasswordObscure.value,
                            icon: FontAwesomeIcons.keycdn,
                            suffixIcon: IconButton(
                              onPressed: () {
                                _authPageController
                                        .signUpConfirmPasswordObscure.value =
                                    !_authPageController
                                        .signUpConfirmPasswordObscure.value;
                              },
                              icon: Icon(
                                _authPageController
                                        .signUpConfirmPasswordObscure.value
                                    ? CupertinoIcons.eye_solid
                                    : CupertinoIcons.eye_slash_fill,
                                color: VvcColors.primaryColor2,
                              ),
                            ),
                            onValidate: (text) {
                              if (text!.length < 6) {
                                return "Password Must Be At Least 6 Characters";
                              } else if (text !=
                                  _authPageController
                                      .signUpPasswordController.text) {
                                return "Password didn't match";
                              }
                            },
                          )),
                      VvcStyle.defaultVerticalSpacer,
                      VvcStyle.defaultVerticalSpacer,
                      VvcElevatedButton.text(
                          label: "Sign Up",
                          onPressed: () async {
                            //todo: Login
                            await _authController.signUp();
                            _authPageController.clearFields();
                          }),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VvcSubHeading(text: "Already A User? "),
                          GestureDetector(
                            onTap: () {
                              _authPageController.clearFields();
                              _authPageController.pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: VvcSubHeading(text: "Log In!"),
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
