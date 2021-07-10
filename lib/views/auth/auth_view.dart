import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/controllers/auth_controller/auth_controller.dart';
import 'package:vvc/views/auth/auth_pages/login_page.dart';
import 'package:vvc/views/auth/auth_pages/sign_up_page.dart';
import 'package:vvc/views/bottom_nav_bar/bottom_nav_bar.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _authController.getCurrentUser == null
        ? AuthPages(authPageController: _authController)
        : BottomNavBarPage());
  }
}

class AuthPages extends StatelessWidget {
  const AuthPages({
    Key? key,
    required AuthController authPageController,
  })  : _authController = authPageController,
        super(key: key);

  final AuthController _authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _authController.pageController,
          children: [
            LoginPage(
              authPageController: _authController,
            ),
            SignUpPage(
              authPageController: _authController,
            ),
          ],
        ),
      ),
    );
  }
}
