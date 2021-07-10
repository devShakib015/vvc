import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/firebase_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/models/user_model.dart';
import 'package:vvc/widgets/vvc_dialog.dart';
import 'package:vvc/widgets/vvc_snackbar.dart';

class ProfileController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  //Form Keys
  final nameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  //TextEditing Controllers
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  //Reactive User Mode
  Rx<UserModel> _user = UserModel(
    id: Get.find<AuthController>().getCurrentUser!.uid,
    email: Get.find<AuthController>().getCurrentUser!.email!,
  ).obs;

  UserModel get user => _user.value;

  @override
  void onInit() {
    _user.bindStream(
      FirebaseConstants.userCollection
          .doc(_authController.getCurrentUser!.uid)
          .snapshots()
          .map((event) {
        return UserModel.fromMap(event.data()!);
      }),
    );
    super.onInit();
  }

  void updateUserName({required String name}) async {
    try {
      VvcDialog.showLoading();
      await _authController.getCurrentUser!.updateDisplayName(name);
      await FirebaseConstants.userCollection.doc(_user.value.id).update(
            UserModel(
              id: _user.value.id,
              email: _user.value.email,
              name: name,
              profilePicUrl: _user.value.profilePicUrl,
            ).toMap(),
          );
      VvcDialog.hideLoading();
      clearFields();
      VvcSnackBar.showSnackBar(
          title: "Success!", message: "Name is successfully updated!");
    } catch (e) {
      VvcDialog.hideLoading();
      VvcSnackBar.showErrorSnackBar(message: "Something went wrong!");
    }
  }

  void updateUserProfilePic({required String profilePicUrl}) async {
    try {
      VvcDialog.showLoading();
      await _authController.getCurrentUser!.updatePhotoURL(profilePicUrl);

      await FirebaseConstants.userCollection.doc(_user.value.id).update(
            UserModel(
              id: _user.value.id,
              email: _user.value.email,
              name: _user.value.name,
              profilePicUrl: profilePicUrl,
            ).toMap(),
          );
      VvcDialog.hideLoading();

      VvcSnackBar.showSnackBar(
          title: "Success!",
          message: "Profile Picture is successfully updated!");
    } catch (e) {
      VvcDialog.hideLoading();
      VvcSnackBar.showErrorSnackBar(message: "Something went wrong!");
    }
  }

  void updateUserEmail({required String email}) async {
    try {
      VvcDialog.showLoading();
      await _authController.getCurrentUser!.updateEmail(email);
      await FirebaseConstants.userCollection.doc(_user.value.id).update(
            UserModel(
              id: _user.value.id,
              email: email,
              name: _user.value.name,
              profilePicUrl: _user.value.profilePicUrl,
            ).toMap(),
          );
      VvcDialog.hideLoading();
      clearFields();
      VvcSnackBar.showSnackBar(
          title: "Success!", message: "Email is successfully updated!");
    } catch (e) {
      VvcDialog.hideLoading();
      VvcSnackBar.showErrorSnackBar(message: "Something went wrong!");
    }
  }

  void verifyUserEmail() async {
    try {
      await _authController.getCurrentUser!.sendEmailVerification();

      VvcSnackBar.showSnackBar(
          title: "Verification!",
          message:
              "A verification link is sent to your email. Click the link and verify it!\nLog out and login again to see the effect!");
    } catch (e) {
      VvcSnackBar.showErrorSnackBar(message: "Something went wrong!");
    }
  }

  void updateUserPassword({required String pass}) async {
    try {
      VvcDialog.showLoading();
      await _authController.getCurrentUser!.updatePassword(pass);
      VvcDialog.hideLoading();
      clearFields();
      VvcSnackBar.showSnackBar(
          title: "Success!",
          message: "Password is successfully chnaged to new one!");
    } catch (e) {
      VvcDialog.hideLoading();
      VvcSnackBar.showErrorSnackBar(message: "Something went wrong!");
    }
  }

  void clearFields() {
    nameTextEditingController.clear();
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
}
