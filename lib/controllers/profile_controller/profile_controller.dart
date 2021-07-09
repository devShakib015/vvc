import 'package:get/get.dart';
import 'package:vvc/constants/firebase_constants.dart';
import 'package:vvc/models/user_model.dart';

class ProfileController extends GetxController {
  Rx<UserModel> _user = UserModel(
          id: FirebaseConstants.currentUser.uid,
          email: FirebaseConstants.currentUser.email!)
      .obs;

  UserModel get user => _user.value;

  @override
  void onInit() {
    _user.bindStream(
      FirebaseConstants.userCollection
          .doc(FirebaseConstants.currentUser.uid)
          .snapshots()
          .map((event) {
        return UserModel.fromMap(event.data()!);
      }),
    );
    super.onInit();
  }

  void updateUserInfo({String? name, String? profilePicUrl}) async {
    await FirebaseConstants.userCollection.doc(_user.value.id).update(UserModel(
          id: _user.value.id,
          email: _user.value.email,
          name: name,
          profilePicUrl: profilePicUrl,
        ).toMap());
  }
}
