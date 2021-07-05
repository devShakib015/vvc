import 'package:get/get.dart';

class AuthController extends GetxController {
  Future<void> login() async {
    Get.snackbar(
      "Login",
      "Please wait!",
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
    await Future.delayed(Duration(seconds: 3));

    print("Done!");
  }

  Future<void> signUp() async {
    Get.snackbar(
      "Sign Up",
      "Please wait!",
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
    await Future.delayed(Duration(seconds: 3));
    print("Done!");
  }
}
