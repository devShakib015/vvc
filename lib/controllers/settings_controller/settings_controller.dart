import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';
import 'package:vvc/constants/firebase_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/models/user_model.dart';
import 'package:vvc/models/user_name_model.dart';
import 'package:vvc/widgets/vvc_dialog.dart';
import 'package:vvc/widgets/vvc_snackbar.dart';

class SettingsController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  //Form Keys
  final nameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final userNameFormKey = GlobalKey<FormState>();

  //TextEditing Controllers
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController userNameTextEditingController =
      TextEditingController();

  final TextEditingController currentPasswordTextEditingController =
      TextEditingController();
  final TextEditingController newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController newConfirmPasswordTextEditingController =
      TextEditingController();

  //Obscure Fields
  RxBool currentPasswordObscure = true.obs;
  RxBool newPasswordObscure = true.obs;
  RxBool confirmPasswordObscure = true.obs;

  //Language Index
  RxInt currentLangIndex = 0.obs;

  //Package Info
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";

  //Reactive User Mode
  Rx<UserModel> _user = UserModel(
    userName: "",
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

    getPackageInfo();
    currentLangIndex.value = Get.find<StorageController>().langIndex;
    super.onInit();
  }

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  void updateLanguageIndexStorage(int index) {
    Get.find<StorageController>().updateLanguageIndex(index);
  }

  void updateUserDefaultName({required String name}) async {
    try {
      VvcDialog.showLoading();
      await _authController.getCurrentUser!.updateDisplayName(name);
      await FirebaseConstants.userCollection.doc(_user.value.id).update(
            UserModel(
              id: _user.value.id,
              userName: _user.value.userName,
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
      VvcSnackBar.showErrorSnackBar(message: "error".tr);
    }
  }

  //Updated Profile Picture
  void updateUserProfilePic() async {
    try {
      VvcDialog.showLoading();

      // ignore: invalid_use_of_visible_for_testing_member
      await ImagePicker.platform
          .pickImage(source: ImageSource.gallery)
          .then((image) async {
        Reference storageReference = FirebaseConstants.storage
            .ref()
            .child(_user.value.id)
            .child("Profile Picture")
            .child("avatar");

        UploadTask uploadTask = storageReference.putFile(File(image!.path));
        await uploadTask.whenComplete(() {
          storageReference.getDownloadURL().then((fileURL) async {
            await _authController.getCurrentUser!.updatePhotoURL(fileURL);

            await FirebaseConstants.userCollection.doc(_user.value.id).update(
                  UserModel(
                    id: _user.value.id,
                    userName: _user.value.userName,
                    email: _user.value.email,
                    name: _user.value.name,
                    profilePicUrl: fileURL,
                  ).toMap(),
                );

            VvcDialog.hideLoading();

            VvcSnackBar.showSnackBar(
                title: "Success!",
                message: "Profile Picture is successfully updated!");
          });
        });
      });
    } catch (e) {
      VvcDialog.hideLoading();
      VvcSnackBar.showErrorSnackBar(message: "error".tr);
    }
  }

  //Change User Email
  void updateUserEmail() async {
    VvcDialog.showLoading();
    AuthCredential _authCredential = EmailAuthProvider.credential(
        email: user.email,
        password: currentPasswordTextEditingController.text.trim());

    try {
      await _authController.getCurrentUser!
          .reauthenticateWithCredential(_authCredential)
          .then((value) async {
        try {
          await _authController.getCurrentUser!
              .updateEmail(emailTextEditingController.text.trim());
          await FirebaseConstants.userCollection.doc(_user.value.id).update(
                UserModel(
                  id: _user.value.id,
                  userName: _user.value.userName,
                  email: emailTextEditingController.text.trim(),
                  name: _user.value.name,
                  profilePicUrl: _user.value.profilePicUrl,
                ).toMap(),
              );

          VvcDialog.hideLoading();
          clearFields();

          VvcSnackBar.showSnackBar(
              title: "Success!",
              message: "Email is successfully changed to new one!");
        } on FirebaseAuthException catch (e) {
          VvcDialog.hideLoading();
          if (e.code == "email-already-in-use") {
            VvcSnackBar.showErrorSnackBar(
              message:
                  "Email is already in use. Please try again with different email!",
              durationInSecond: 3,
            );
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      VvcDialog.hideLoading();
      if (e.code == "wrong-password") {
        VvcSnackBar.showErrorSnackBar(
          message: "Your current password is not what we have in our system!",
          durationInSecond: 2,
        );
      } else {
        VvcSnackBar.showErrorSnackBar(
          message:
              "Don't cross your limit to do such tasks again! We have blocked you for a while. Try again later!",
          durationInSecond: 3,
        );
      }
    }
  }

  //Change User name
  void updateUserName() async {
    VvcDialog.showLoading();
    AuthCredential _authCredential = EmailAuthProvider.credential(
        email: user.email,
        password: currentPasswordTextEditingController.text.trim());

    try {
      await _authController.getCurrentUser!
          .reauthenticateWithCredential(_authCredential)
          .then((value) async {
        bool isUserAvailable = await _authController
            .doesUserNameExists(userNameTextEditingController.text.trim());

        if (isUserAvailable) {
          VvcDialog.hideLoading();
          VvcSnackBar.showErrorSnackBar(message: "User name is already taken!");
        } else {
          await FirebaseConstants.userCollection.doc(_user.value.id).update(
                UserModel(
                  id: _user.value.id,
                  userName: userNameTextEditingController.text.trim(),
                  email: _user.value.email,
                  name: _user.value.name,
                  profilePicUrl: _user.value.profilePicUrl,
                ).toMap(),
              );

          await FirebaseConstants.userNameCollection.doc(_user.value.id).update(
                UserName(userName: userNameTextEditingController.text.trim())
                    .toMap(),
              );

          VvcDialog.hideLoading();
          clearFields();

          VvcSnackBar.showSnackBar(
              title: "Success!",
              message: "User name is successfully changed to new one!");
        }
      });
    } on FirebaseAuthException catch (e) {
      VvcDialog.hideLoading();
      if (e.code == "wrong-password") {
        VvcSnackBar.showErrorSnackBar(
          message: "Your current password is not what we have in our system!",
          durationInSecond: 2,
        );
      } else {
        VvcSnackBar.showErrorSnackBar(
          message:
              "Don't cross your limit to do such tasks again! We have blocked you for a while. Try again later!",
          durationInSecond: 3,
        );
      }
    }
  }

  //Verify User Email
  void verifyUserEmail() async {
    try {
      await _authController.getCurrentUser!.sendEmailVerification();

      VvcSnackBar.showSnackBar(
          title: "Verification!",
          durationInSecond: 4,
          message:
              "A verification link is sent to your email. Click the link and verify it!\nLog out and login again to see the effect!");
    } catch (e) {
      VvcSnackBar.showErrorSnackBar(message: "error".tr);
    }
  }

  //Change Password
  void updateUserPassword() async {
    VvcDialog.showLoading();
    AuthCredential _authCredential = EmailAuthProvider.credential(
        email: user.email,
        password: currentPasswordTextEditingController.text.trim());

    try {
      await _authController.getCurrentUser!
          .reauthenticateWithCredential(_authCredential)
          .then((value) async {
        await _authController.getCurrentUser!.updatePassword(
            newConfirmPasswordTextEditingController.text.trim());

        VvcDialog.hideLoading();
        clearFields();

        VvcSnackBar.showSnackBar(
            title: "Success!",
            message: "Password is successfully chnaged to new one!");
      });
    } on FirebaseAuthException catch (e) {
      VvcDialog.hideLoading();
      if (e.code == "wrong-password") {
        VvcSnackBar.showErrorSnackBar(
          message: "Your current password is not what we have in our system!",
          durationInSecond: 2,
        );
      } else {
        VvcSnackBar.showErrorSnackBar(
          message:
              "Don't cross your limit to do such tasks again! We have blocked you for a while. Try again later!",
          durationInSecond: 3,
        );
      }
    }
  }

  void clearFields() {
    nameTextEditingController.clear();
    emailTextEditingController.clear();
    userNameTextEditingController.clear();
    currentPasswordTextEditingController.clear();
    newPasswordTextEditingController.clear();
    newConfirmPasswordTextEditingController.clear();
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    emailTextEditingController.dispose();
    userNameTextEditingController.dispose();
    newPasswordTextEditingController.dispose();
    currentPasswordTextEditingController.dispose();
    newConfirmPasswordTextEditingController.dispose();
    super.dispose();
  }
}
