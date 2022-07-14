import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medstation_partner/widgets/widgets.dart';

import 'homeScreen.dart';
import 'orderScreen.dart';
import 'profileScreen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<dynamic> pages = [
    new HomeScreen(),
    new OrderScreen(),
    new ProfileScreen(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: .1),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0)),
          child: BottomNavigationBar(
            selectedItemColor: _selectedIndex == 0 ? Colors.blue : Colors.blue,
            unselectedItemColor: _selectedIndex == 0
                ? HexColor("#003580", 1)
                : HexColor("#003580", 1),
            backgroundColor: _selectedIndex == 0 ? Colors.white : Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
