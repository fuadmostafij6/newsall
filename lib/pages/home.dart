import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:newsphobia/pages/health.dart';
import 'package:newsphobia/pages/news.dart';
import 'package:newsphobia/pages/sports.dart';
import 'package:newsphobia/pages/User.dart';

class BNV extends StatefulWidget {
  @override
  _BNVState createState() => _BNVState();
}

class _BNVState extends State<BNV> {
  var _page = 0;
  final pages = [
    News(),
    Sports(),
    Health(),
    User(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          color: Colors.redAccent,
          buttonBackgroundColor: Colors.redAccent,
          backgroundColor: Colors.grey,
          animationCurve: Curves.easeIn,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.sports_baseball_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.medical_services_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ],
        ),
        body: pages[_page],
      ),
    );
  }
}
