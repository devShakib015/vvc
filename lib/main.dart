import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/image_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/widgets/vvc_elevated_button.dart';
import 'package:vvc/widgets/vvc_app_bar_title.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VVC',
      debugShowCheckedModeBanner: false,
      theme: VvcStyle.vvcTheme(context),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      appBar: AppBar(
        title: VvcAppBarTitle(text: "Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Hello Shakib!"),
            Image.asset(VvcImages.logo),
            VvcElevatedButton.text(label: "Login", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
