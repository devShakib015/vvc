import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/controllers/contacts_controller/contacts_controller.dart';
import 'package:vvc/controllers/home_controller/home_controller.dart';
import 'package:vvc/controllers/profile_controller/profile_controller.dart';
import 'package:vvc/controllers/settings_controller/settings_controller.dart';
import 'package:vvc/views/Profile/profile_view.dart';
import 'package:vvc/views/contacts/contact_view.dart';
import 'package:vvc/views/home/home_view.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _index = 0;
  List<Widget> _tabPages = [
    HomeView(),
    ContactView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    //Put All the controllers

    Get.put(HomeController());
    Get.put(ContactsController());
    Get.put(ProfileController());
    Get.put(SettingsController());

    //Bottom Nav bar
    return Scaffold(
      body: PageTransitionSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          fillColor: Colors.transparent,
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: _tabPages[_index],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: GNav(
          duration: Duration(milliseconds: 500),
          tabBorderRadius: 10,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          gap: 8,
          color: VvcColors.fadeLightColor,
          activeColor: Colors.white,
          iconSize: 24,
          onTabChange: (index) {
            setState(() {
              _index = index;
            });
          },
          tabBackgroundGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [VvcColors.primaryColor1, VvcColors.primaryColor2],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          tabs: [
            GButton(
              icon: CupertinoIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: CupertinoIcons.person_2,
              text: 'Contacts',
            ),
            GButton(
              icon: CupertinoIcons.person,
              text: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}
