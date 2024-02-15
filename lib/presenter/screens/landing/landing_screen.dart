import 'package:flutter/material.dart';
import 'package:nasiya/presenter/pages/favourite/favourite_page.dart';
import 'package:nasiya/presenter/pages/notification/notification.dart';
import 'package:nasiya/presenter/pages/profile/profile.dart';

import '../../pages/home/home_page.dart';

class LandingScreen extends StatefulWidget {
  final int currentPage;

  const LandingScreen({required this.currentPage, super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = const HomePage();

  List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
        icon: Icon(Icons.home_filled, size: 33), label: ""),
    const BottomNavigationBarItem(
        icon: Icon(Icons.bookmark, size: 33), label: ""),
    const BottomNavigationBarItem(
        icon: Icon(Icons.notifications, size: 33), label: ""),
    const BottomNavigationBarItem(icon: Icon(Icons.person, size: 33), label: "")
  ];

  List<Widget> bottomNavScreen = <Widget>[
    const HomePage(),
    const FavouritePage(),
    const NotificationPage(),
    const ProfileScreen(),
    // const CashFlowPage(),
  ];

  @override
  void initState() {
    currentIndex = widget.currentPage;

    // } else if(currentIndex == 3){
    //   currentScreen = const ServicesPage();
    // } else if (currentIndex == 2) {
    //   currentScreen = const PaymentPage();
    // } else
    if (currentIndex == 3) {
      currentScreen = const ProfileScreen();
    } else if (currentIndex == 2) {
      currentScreen = const NotificationPage();
    } else if (currentIndex == 1) {
      currentScreen = const FavouritePage();
    } else {
      currentScreen = const HomePage();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentScreen = bottomNavScreen[currentIndex];
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black26,
        onTap: (int index) {
          setState(() {
            currentScreen = bottomNavScreen[index];
            currentIndex = index;
          });
        },
        items: bottomNavItems,
      ),
    );
  }
}
