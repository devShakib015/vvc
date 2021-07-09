import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/style_constants.dart';

class LoadingPage extends StatelessWidget {
  final String? message;
  const LoadingPage({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      body: SafeArea(
        child: Container(
          padding: VvcStyle.defaultSidePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCube(
                color: Colors.white,
                size: 30,
                duration: Duration(seconds: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  message ?? "Loading...",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
