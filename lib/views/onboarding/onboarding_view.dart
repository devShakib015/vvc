import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/constants/style_constants.dart';
import 'package:vvc/controllers/onboarding_controller/onboarding_controller.dart';
import 'package:vvc/widgets/vvc_elevated_button.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({Key? key}) : super(key: key);

  final OnBoardingController _onBoardingController =
      Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  _onBoardingController.currentPage.value = index;
                },
                physics: BouncingScrollPhysics(),
                controller: _onBoardingController.pageController,
                children: _onBoardingController.onBoardingPages,
              ),
            ),
            VvcStyle.defaultVerticalSpacer,
            OnBoardingFooter(onBoardingController: _onBoardingController),
            VvcStyle.defaultVerticalSpacer
          ],
        ),
      ),
    );
  }
}

class OnBoardingFooter extends StatelessWidget {
  const OnBoardingFooter({
    Key? key,
    required OnBoardingController onBoardingController,
  })  : _onBoardingController = onBoardingController,
        super(key: key);

  final OnBoardingController _onBoardingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //First Button
          VvcElevatedButton.iconWithText(
            label: "Skip",
            icon: Icon(
              Icons.skip_next_rounded,
              size: 16,
            ),
            onPressed: _onBoardingController.goToAuthPage,
          ),

          //Dots
          VvcStyle.defaultHorizontalSpacer,
          OnBoardingDots(onBoardingController: _onBoardingController),
          VvcStyle.defaultHorizontalSpacer,

          // Second Button
          Obx(() => _onBoardingController.currentPage.value ==
                  _onBoardingController.onBoardingPages.length - 1
              ? VvcElevatedButton.iconWithText(
                  label: "Done",
                  icon: Icon(
                    Icons.done_all,
                    size: 16,
                  ),
                  onPressed: _onBoardingController.goToAuthPage,
                )
              : VvcElevatedButton.iconWithText(
                  label: "Next",
                  icon: Icon(
                    CupertinoIcons.chevron_forward,
                    size: 16,
                  ),
                  onPressed: () {
                    _onBoardingController.pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                )),
        ],
      ),
    );
  }
}

class OnBoardingDots extends StatelessWidget {
  const OnBoardingDots({
    Key? key,
    required OnBoardingController onBoardingController,
  })  : _onBoardingController = onBoardingController,
        super(key: key);

  final OnBoardingController _onBoardingController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: _onBoardingController.onBoardingPages.map(
            (page) {
              double _dotWidthAndHeight =
                  _onBoardingController.currentPage.value ==
                          _onBoardingController.onBoardingPages.indexOf(page)
                      ? 13
                      : 8;
              return Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: _onBoardingController.currentPage.value ==
                            _onBoardingController.onBoardingPages.indexOf(page)
                        ? VvcColors.primaryColor1
                        : VvcColors.accentColor1,
                  ),
                  width: _dotWidthAndHeight,
                  height: _dotWidthAndHeight,
                ),
              );
            },
          ).toList(),
        ));
  }
}
