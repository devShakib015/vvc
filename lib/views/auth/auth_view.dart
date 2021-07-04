import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/controllers/auth_controller/auth_page_controller.dart';
import 'package:vvc/views/auth/auth_pages/login_page.dart';
import 'package:vvc/views/auth/auth_pages/sign_up_page.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);

  final AuthController _authController = Get.put(AuthController());
  final AuthPageController _authPageController = Get.put(AuthPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      body: Container(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _authPageController.pageController,
          children: [
            LoginPage(),
            SignUpPage(),
          ],
        ),
      ),
    );
  }
}
