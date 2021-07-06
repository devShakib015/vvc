import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:vvc/widgets/vvc_snackbar.dart';

class AuthPageController extends GetxController {
  final PageController pageController = PageController();
  final AuthController _authController = Get.put(AuthController());
  final StorageController _storageController = Get.find<StorageController>();

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

  //Obscure Fields
  RxBool loginPasswordObscure = true.obs;
  RxBool signUpPasswordObscure = true.obs;
  RxBool signUpConfirmPasswordObscure = true.obs;

  //Remeber Me values
  bool get getRememberMe => _authController.remeberLoginInfo.value;

  set setRememberMe(bool value) {
    _authController.remeberLoginInfo.value = value;
  }

  //Privacy Policy
  RxBool isAcceptedPrivacyPolicy = false.obs;

  void onPressedLogin() async {
    //todo: Login
    if (loginFormKey.currentState!.validate()) {
      await _authController.login(
        loginEmailController.text.trim(),
        loginPasswordController.text.trim(),
      );
      clearFields();
      Get.to(() => BottomNavBarPage());
    } else {
      VvcSnackBar.showErrorSnackBar(message: "Login Error!");
    }
  }

  void onPressedSignUp() async {
    //todo: Sign Up

    if (signUpFormKey.currentState!.validate()) {
      if (isAcceptedPrivacyPolicy.value) {
        await _authController.signUp(
          signUpEmailController.text.trim(),
          signUpPasswordController.text.trim(),
        );
        clearFields();
        Get.to(() => BottomNavBarPage());
      } else {
        VvcSnackBar.showSnackBar(
            title: "Privacy Policy",
            message:
                "Please read and accept our privacy policy and then try to sign up!");
      }
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
  void onReady() {
    if (_storageController.savedEmail != null &&
        _storageController.savedPassword != null) {
      loginEmailController.text = _storageController.savedEmail!;
      loginPasswordController.text = _storageController.savedPassword!;
    }
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
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
