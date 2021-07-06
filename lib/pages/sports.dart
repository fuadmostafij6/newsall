import 'package:flutter/material.dart';
import 'package:newsphobia/pages/cricket.dart';
import 'package:newsphobia/pages/football.dart';
import 'package:newsphobia/pages/hockey.dart';

class Sports extends StatefulWidget {
  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sports',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            //     appBar: AppBar(
            //
            //   backgroundColor: Colors.black,
            // ),
            title: Text(
              'NewsPhobia',
              style: TextStyle(color: Colors.redAccent),
            ),
            centerTitle: true,

            backgroundColor: Colors.black,
            bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.redAccent,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.redAccent),
              tabs: [
                Tab(
                  text: 'Football',
                ),
                Tab(
                  text: 'Cricket',
                ),
                Tab(
                  text: 'Hockey',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Football(),
              Cricket(),
              Hockey(),
            ],
          ),
        ),
      ),
    );
  }
}
