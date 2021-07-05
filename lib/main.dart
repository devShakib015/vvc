import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/views/auth/auth_view.dart';
import 'package:vvc/views/onboarding/onboarding_view.dart';

void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final StorageController _storageController = Get.put(StorageController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VVC',
      debugShowCheckedModeBanner: false,
      theme: VvcStyle.vvcTheme(context),
      home:
          _storageController.isOnBoardingShown ? AuthView() : OnBoardingView(),
    );
  }
}
