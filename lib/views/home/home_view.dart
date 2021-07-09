import 'package:flutter/material.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/widgets/vvc_app_bar_title.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      appBar: AppBar(
        title: VvcAppBarTitle(text: "Home"),
      ),
      body: Container(
        child: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
