import 'package:get/get.dart';

import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/widgets/vvc_dialog.dart';
import 'package:vvc/widgets/vvc_snackbar.dart';

class AuthController extends GetxController {
  final StorageController _storageController = Get.find<StorageController>();

  //Remember Login Info
  RxBool remeberLoginInfo = false.obs;

  Future<void> login(String email, String pass) async {
    //TODO:Login

    if (remeberLoginInfo.value) {
      _storageController.updateSavedEmailAndPassword(email, pass);
    } else {
      _storageController.updateSavedEmailAndPassword(null, null);
    }

    try {
      VvcDialog.showLoading();
      await Future.delayed(Duration(seconds: 3));
      VvcDialog.hideLoading();
    } catch (e) {
      VvcSnackBar.showErrorSnackBar(message: "Login Error!");
    }

    print("Done!");
  }

  Future<void> resetPassword(String email) async {
    //TODO:Reset password

    try {
      VvcDialog.showLoading();
      await Future.delayed(Duration(seconds: 3));
      VvcDialog.hideLoading();
    } catch (e) {
      VvcSnackBar.showErrorSnackBar(message: "Send Request Error!");
    }

    print("Done!");
  }

  Future<void> signUp(String email, String pass) async {
    //TODO:Sign Up

    if (remeberLoginInfo.value) {
      _storageController.updateSavedEmailAndPassword(email, pass);
    } else {
      _storageController.updateSavedEmailAndPassword(null, null);
    }

    try {
      VvcDialog.showLoading();
      await Future.delayed(Duration(seconds: 3));
      VvcDialog.hideLoading();
    } catch (e) {
      VvcSnackBar.showErrorSnackBar(message: "Sign Up Error!");
    }

    print("Done!");
  }
}
