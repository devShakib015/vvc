import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vvc/constants/color_constants.dart';
import 'package:vvc/views/Profile/profile_view.dart';
import 'package:vvc/views/contacts/contact_view.dart';
import 'package:vvc/views/home/home_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  List<Widget> _tabPages = [
    HomeView(),
    ContactView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VvcColors.bgColor,
      body: _tabPages[_index],
      bottomNavigationBar: GNav(
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
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
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
    );
  }
}
