import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/views/auth/auth_view.dart';
import 'package:vvc/views/onboarding/onboarding_pages/onboarding_first_page.dart';
import 'package:vvc/views/onboarding/onboarding_pages/onboarding_second_page.dart';
import 'package:vvc/views/onboarding/onboarding_pages/onboarding_third_page.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();

  RxInt currentPage = 0.obs;

  List<Widget> onBoardingPages = [
    OnBoardingFirstPage(),
    OnBoardingSecondPage(),
    OnBoardingThirdPage(),
  ];

  void goToAuthPage() async {
    Get.find<StorageController>().updateOnBoardingStorage(true);
    Get.offAll(
      () => AuthView(),
      transition: Transition.leftToRightWithFade,
    );
  }
}
