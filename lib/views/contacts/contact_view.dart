import 'package:flutter/material.dart';
import 'package:vvc/widgets/vvc_app_bar_title.dart';
import 'package:get/get.dart';

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: VvcAppBarTitle(text: "contacts".tr),
      ),
      body: Container(
        child: Center(
          child: Text("Contacts"),
        ),
      ),
    );
  }
}
