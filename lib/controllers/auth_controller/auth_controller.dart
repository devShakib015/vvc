import 'package:get/get.dart';
import 'package:vvc/widgets/vvc_dialog.dart';

class AuthController extends GetxController {
  Future<void> login() async {
    VvcDialog.showLoading();
    await Future.delayed(Duration(seconds: 3));
    VvcDialog.hideLoading();

    print("Done!");
  }

  Future<void> signUp() async {
    VvcDialog.showLoading();
    await Future.delayed(Duration(seconds: 3));
    VvcDialog.hideLoading();

    print("Done!");
  }
}
