import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {
  PageController pageController = PageController();

  //Form keys
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  //Login Text Editing Controller
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  //Sign Up Text Editing Controller
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  RxBool loginPasswordObscure = true.obs;
  RxBool signUpPasswordObscure = true.obs;
  RxBool signUpConfirmPasswordObscure = true.obs;

  //Function to clear all the fields
  void clearFields() {
    loginEmailController.clear();
    loginPasswordController.clear();
    signUpEmailController.clear();
    signUpPasswordController.clear();
    signUpConfirmPasswordController.clear();
  }

  @override
  void dispose() {
    pageController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    super.dispose();
  }
}
