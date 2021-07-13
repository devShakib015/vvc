import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final _box = GetStorage();
  final String _onBoardingStorageKey = "isOnBoardingShown";
  final String _saveLoginInfoKey = "loginInfo";
  final String _languageIndexStorageKey = "languageIndex";

  //onBoarding Storage
  late bool _onBoardingValue;
  late RxBool _isOnBoardingShown;

  bool get isOnBoardingShown => _isOnBoardingShown.value;

  void updateOnBoardingStorage(bool val) async {
    _isOnBoardingShown.value = val;
    await _box.write(_onBoardingStorageKey, val);
  }

  //Login Info Storage
  late String? _savedEmail;
  late String? _savedPasword;

  String? get savedEmail => _savedEmail;
  String? get savedPassword => _savedPasword;

  void updateSavedEmailAndPassword(String? email, String? pass) async {
    if (email == null && pass == null) {
      await _box.write(_saveLoginInfoKey, null);
    } else {
      await _box.write(_saveLoginInfoKey, {
        "email": email,
        "pass": pass,
      });
    }
  }

  //Language Storage
  int langIndex = 0;

  void updateLanguageIndex(int index) async {
    await _box.write(_languageIndexStorageKey, index);
  }

  @override
  void onInit() {
    _onBoardingValue = _box.read(_onBoardingStorageKey) ?? false;
    _isOnBoardingShown = _onBoardingValue.obs;

    var _loginInfo = _box.read(_saveLoginInfoKey);

    if (_loginInfo == null) {
      _savedEmail = null;
      _savedPasword = null;
    } else {
      _savedEmail = _loginInfo["email"];
      _savedPasword = _loginInfo["pass"];
    }

    _box.listenKey(_saveLoginInfoKey, (value) {
      if (value == null) {
        _savedEmail = null;
        _savedPasword = null;
      } else {
        _savedEmail = value["email"];
        _savedPasword = value["pass"];
      }
    });

    langIndex = _box.read(_languageIndexStorageKey) ?? 0;

    _box.listenKey(_languageIndexStorageKey, (index) {
      langIndex = index;
    });

    super.onInit();
  }
}
