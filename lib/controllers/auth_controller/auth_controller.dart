import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vvc/constants/firebase_constants.dart';
import 'package:vvc/controllers/contacts_controller/contacts_controller.dart';
import 'package:vvc/controllers/home_controller/home_controller.dart';
import 'package:vvc/controllers/profile_controller/profile_controller.dart';
import 'package:vvc/controllers/settings_controller/settings_controller.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/models/user_model.dart';
import 'package:vvc/models/user_name_model.dart';
import 'package:vvc/widgets/vvc_dialog.dart';
import 'package:vvc/widgets/vvc_snackbar.dart';

class AuthController extends GetxController {
  final StorageController _storageController = Get.find<StorageController>();
  final PageController pageController = PageController();

  //For Auth Functions

  //Remember Login Info
  RxBool remeberLoginInfo = false.obs;

  //Current User
  Rx<User?> _currentUser = FirebaseConstants.auth.currentUser.obs;
  User? get getCurrentUser => _currentUser.value;

  @override
  void onInit() {
    _currentUser.bindStream(FirebaseConstants.auth.userChanges());
    super.onInit();
  }

  //Login Using Email and Password
  //!Login
  Future<void> login(String email, String pass) async {
    try {
      VvcDialog.showLoading();
      await FirebaseConstants.auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (remeberLoginInfo.value) {
        _storageController.updateSavedEmailAndPassword(email, pass);
      } else {
        _storageController.updateSavedEmailAndPassword(null, null);
      }
      clearFields();

      VvcDialog.hideLoading();
    } on FirebaseAuthException catch (e) {
      print(e);
      VvcDialog.hideLoading();
      if (e.code == 'user-not-found') {
        VvcSnackBar.showErrorSnackBar(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        VvcSnackBar.showErrorSnackBar(
            message: 'Wrong password provided for that user.');
      }
    } catch (e) {
      VvcDialog.hideLoading();
      print(e);
      VvcSnackBar.showErrorSnackBar(message: 'Someting went wrong!');
    }
  }

  //Sign up using email and password
  //!Sign Up
  Future<void> signUp(String userName, String email, String pass) async {
    try {
      VvcDialog.showLoading();
      bool _isAlreadyUser = await doesUserNameExists(userName);
      if (_isAlreadyUser) {
        VvcDialog.hideLoading();
        VvcSnackBar.showErrorSnackBar(message: 'User name already exists.');
      } else {
        await FirebaseConstants.auth
            .createUserWithEmailAndPassword(email: email, password: pass)
            .then((value) async {
          //Save to users
          await FirebaseConstants.userCollection
              .doc(value.user!.uid)
              .set(UserModel(
                id: value.user!.uid,
                userName: userName,
                email: email,
                name: null,
                profilePicUrl: null,
              ).toMap());

          //Save To UserName
          await FirebaseConstants.userNameCollection
              .doc(value.user!.uid)
              .set(UserName(userName: userName).toMap());

          await Future.delayed(Duration(seconds: 1));
        });

        if (remeberLoginInfo.value) {
          _storageController.updateSavedEmailAndPassword(email, pass);
        } else {
          _storageController.updateSavedEmailAndPassword(null, null);
        }
        clearFields();
        VvcDialog.hideLoading();
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      VvcDialog.hideLoading();
      if (e.code == 'weak-password') {
        VvcSnackBar.showErrorSnackBar(
            message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        VvcSnackBar.showErrorSnackBar(
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      VvcDialog.hideLoading();
      print(e);
      VvcSnackBar.showErrorSnackBar(message: 'Someting went wrong!');
    }
  }

  //Login using Google Account
  //!Google Login
  Future<void> loginUsingGoogle() async {
    try {
      VvcDialog.showLoading();

      final GoogleSignInAccount? _googleUser = await GoogleSignIn().signIn();

      if (_googleUser != null) {
        final GoogleSignInAuthentication _googleAuth =
            await _googleUser.authentication;

        // Create a new credential
        final _credential = GoogleAuthProvider.credential(
          accessToken: _googleAuth.accessToken,
          idToken: _googleAuth.idToken,
        );

        try {
          await FirebaseConstants.auth
              .signInWithCredential(_credential)
              .then((userCredential) {
            FirebaseConstants.userCollection.get().then((querySnapshot) async {
              final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                  _userList = querySnapshot.docs;
              final List<String> _userUidList = [];
              _userList.forEach((element) {
                _userUidList.add(element.id);
              });

              if (!_userUidList.contains(userCredential.user!.uid)) {
                //Save to Users
                await FirebaseConstants.userCollection
                    .doc(userCredential.user!.uid)
                    .set(UserModel(
                      id: userCredential.user!.uid,
                      userName: userCredential.user!.email!,
                      email: userCredential.user!.email!,
                      name: userCredential.user!.displayName,
                      profilePicUrl: userCredential.user!.photoURL,
                    ).toMap());

                //Save To UserName
                await FirebaseConstants.userNameCollection
                    .doc(userCredential.user!.uid)
                    .set(UserName(userName: userCredential.user!.email!)
                        .toMap());

                await Future.delayed(Duration(seconds: 1));
              }
            });
          });

          VvcDialog.hideLoading();
        } catch (e) {
          print(e);
          VvcDialog.hideLoading();
        }
      } else {
        VvcDialog.hideLoading();
        VvcSnackBar.showErrorSnackBar(message: 'Someting went wrong!');
      }
    } catch (e) {
      VvcDialog.hideLoading();
      print(e);
      VvcSnackBar.showErrorSnackBar(message: 'Someting went wrong!');
    }
  }

  //Reset Password using email
  //!Reset password
  Future<void> resetPassword(String email) async {
    Get.back();
    try {
      VvcDialog.showLoading();
      await FirebaseConstants.auth.sendPasswordResetEmail(email: email);

      clearFields();
      VvcDialog.hideLoading();
      VvcSnackBar.showSnackBar(
        title: "Request Sent!",
        message:
            "A password reset email is sent to your mail. Check and reset your password!",
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "user-not-found") {
        VvcDialog.hideLoading();
        VvcSnackBar.showErrorSnackBar(message: "User Not Found!");
      }
    } catch (e) {
      VvcDialog.hideLoading();
      VvcSnackBar.showErrorSnackBar(message: "Send Request Error!");
    }
  }

  //Log out from firebase auth
  //!Log Out
  Future<void> logOut() async {
    Get.back();

    try {
      Get.back();
      VvcDialog.showLoading();
      await Future.delayed(Duration(seconds: 2));
      await FirebaseConstants.auth.signOut().then((value) async {
        await Get.delete<HomeController>();
        await Get.delete<ContactsController>();
        await Get.delete<ProfileController>();
        await Get.delete<SettingsController>();
      });
      VvcDialog.hideLoading();
    } catch (e) {
      VvcDialog.hideLoading();
      VvcSnackBar.showErrorSnackBar(
          message: "There is an error to log you out!");
    }
  }

  //User Name Check
  Future<bool> doesUserNameExists(String userName) async {
    return await FirebaseConstants.userNameCollection
        .where("userName", isEqualTo: userName)
        .get()
        .then((value) {
      return value.docs.isEmpty ? false : true;
    });
  }

  //For Auth pages

  //Form keys
  final loginFormKey = GlobalKey<FormState>();
  final resetPassFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  //Login Text Editing Controller
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  //Reset Password Text Editing Controller
  TextEditingController resetPasswordEmailController = TextEditingController();

  //Sign Up Text Editing Controller
  TextEditingController signUpUserNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  //Obscure Fields
  RxBool loginPasswordObscure = true.obs;
  RxBool signUpPasswordObscure = true.obs;
  RxBool signUpConfirmPasswordObscure = true.obs;

  //Remeber Me values
  bool get getRememberMe => remeberLoginInfo.value;

  set setRememberMe(bool value) {
    remeberLoginInfo.value = value;
  }

  //Privacy Policy
  RxBool isAcceptedPrivacyAndTerms = false.obs;

  void onPressedLogin() async {
    if (loginFormKey.currentState!.validate()) {
      await login(
        loginEmailController.text.trim(),
        loginPasswordController.text.trim(),
      );
    }
  }

  void onPressedSignUp() async {
    if (signUpFormKey.currentState!.validate()) {
      if (isAcceptedPrivacyAndTerms.value) {
        await signUp(
          signUpUserNameController.text.trim(),
          signUpEmailController.text.trim(),
          signUpPasswordController.text.trim(),
        );
      } else {
        VvcSnackBar.showSnackBar(
          title: "Privacy, Terms and Condtions",
          message:
              "Please read and accept our privacy policy and terms to create an account!",
        );
      }
    }
  }

  void onPressedResetPassword() async {
    if (resetPassFormKey.currentState!.validate()) {
      await resetPassword(resetPasswordEmailController.text.trim());
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

  void loadSavedLoginInfo() {
    if (_storageController.savedEmail != null &&
        _storageController.savedPassword != null) {
      VvcDialog.showConfirmDialog(
        title:
            "Saved login info found for account with email -\n'${_storageController.savedEmail}' \nDo you want to login using this email?",
        onConfirmPressed: () {
          Get.back();
          loginEmailController.text = _storageController.savedEmail!;
          loginPasswordController.text = _storageController.savedPassword!;
        },
        cancelButtonText: "No",
        confirmButtonText: "Yes",
      );
    }
  }

  //Function to clear all the fields
  void clearFields() {
    loginEmailController.clear();
    loginPasswordController.clear();
    resetPasswordEmailController.clear();
    signUpEmailController.clear();
    signUpUserNameController.clear();
    signUpPasswordController.clear();
    signUpConfirmPasswordController.clear();
  }

  @override
  void dispose() {
    pageController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    resetPasswordEmailController.dispose();
    signUpEmailController.dispose();
    signUpUserNameController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    super.dispose();
  }
}
