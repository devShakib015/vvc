import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/controllers/storage_controller/storage_controller.dart';
import 'package:vvc/widgets/vvc_app_bar_title.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => GestureDetector(
                  onTap: () {
                    Get.find<StorageController>().updateOnBoardingStorage(
                        !Get.find<StorageController>().isOnBoardingShown);
                  },
                  child: Card(
                    child: Get.find<StorageController>().isOnBoardingShown
                        ? ListTile(
                            title: Text("Turn On Onboarding!"),
                            trailing: Icon(Icons.switch_left),
                          )
                        : ListTile(
                            title: Text("Turn Off Onboarding!"),
                            trailing: Icon(Icons.switch_right),
                          ),
                  ),
                ))
          ],
        ),
      ),
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
