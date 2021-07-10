import 'package:flutter/material.dart';
import 'package:vvc/constants/style_constants.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({
    Key? key,
  }) : super(key: key);

  //final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: VvcStyle.defaultSidePadding,
    );
  }
}
