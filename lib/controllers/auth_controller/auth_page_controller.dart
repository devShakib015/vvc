import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:vvc/widgets/vvc_snackbar.dart';

class AuthPageController extends GetxController {
  final PageController pageController = PageController();

  final AuthController _authController = Get.find<AuthController>();

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

  void onPressedLogin() async {
    //todo: Login
    if (loginFormKey.currentState!.validate()) {
      await _authController.login();
      clearFields();
      Get.to(() => BottomNavBarPage());
    } else {
      VvcSnackBar.showErrorSnackBar(message: "Login Error!");
    }
  }

  void onPressedSignUp() async {
    //todo: Sign Up
    if (signUpFormKey.currentState!.validate()) {
      await _authController.signUp();
      clearFields();
      Get.to(() => BottomNavBarPage());
    } else {
      VvcSnackBar.showErrorSnackBar(message: "Sign Up Error");
    }
  }

  void goToSignUpPage() {
    clearFields();
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void goToLoginPage() {
    clearFields();
    pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

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
