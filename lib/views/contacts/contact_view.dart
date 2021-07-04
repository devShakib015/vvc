import 'package:flutter/material.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/widgets/vvc_app_bar_title.dart';

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      appBar: AppBar(
        title: VvcAppBarTitle(text: "Contacts"),
      ),
      body: Container(
        child: Center(
          child: Text("Contacts"),
        ),
      ),
    );
  }
}
