import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final box = GetStorage();
  final String onBoardingStorageKey = "isOnBoardingShown";

  late bool _onBoardingValue;
  late RxBool _isOnBoardingShown;

  bool get isOnBoardingShown => _isOnBoardingShown.value;

  void updateOnBoardingStorage(bool val) async {
    _isOnBoardingShown.value = val;
    await box.write(onBoardingStorageKey, val);
  }

  @override
  void onInit() {
    _onBoardingValue = box.read(onBoardingStorageKey) ?? false;
    _isOnBoardingShown = _onBoardingValue.obs;
    super.onInit();
  }
}
