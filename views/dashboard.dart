import 'package:flutter/material.dart';
import 'tabs/profile.dart';
import 'tabs/home.dart';
import 'tabs/map.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => DashboardState();
}

class DashboardState extends State<DashboardScreen> {
  PageController pageController;
  int page = 0;

  @override
  void initState() {
    super.initState();
    pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: new PageView(
            children: [
              HomeScreen(),
              MapsDemo(),
              ProfileScreen(),
            ],
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
            controller: pageController,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.map),
                title: new Text('Google Map'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile'))
            ],
            fixedColor: Colors.red,
            onTap: navigationTapped,
            currentIndex: page,
          )),
    );
  }
}
