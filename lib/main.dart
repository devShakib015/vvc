import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/views/auth/auth_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VVC',
      debugShowCheckedModeBanner: false,
      theme: VvcStyle.vvcTheme(context),
      home: AuthView(),
    );
  }
}
