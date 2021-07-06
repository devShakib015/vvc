import 'package:get/get.dart';

import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/widgets/vvc_dialog.dart';

class AuthController extends GetxController {
  final StorageController _storageController = Get.find<StorageController>();

  //Remember Login Info
  RxBool remeberLoginInfo = false.obs;

  Future<void> login(String email, String pass) async {
    VvcDialog.showLoading();
    if (remeberLoginInfo.value) {
      _storageController.updateSavedEmailAndPassword(email, pass);
    } else {
      _storageController.updateSavedEmailAndPassword(null, null);
    }

    await Future.delayed(Duration(seconds: 3));
    VvcDialog.hideLoading();

    print("Done!");
  }

  Future<void> signUp(String email, String pass) async {
    VvcDialog.showLoading();
    if (remeberLoginInfo.value) {
      _storageController.updateSavedEmailAndPassword(email, pass);
    } else {
      _storageController.updateSavedEmailAndPassword(null, null);
    }
    await Future.delayed(Duration(seconds: 3));
    VvcDialog.hideLoading();

    print("Done!");
  }
}
