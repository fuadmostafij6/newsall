import 'package:flutter/material.dart';
import 'package:newsphobia/pages/recent.dart';
import 'package:newsphobia/pages/topNews.dart';
import 'package:newsphobia/pages/world.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'news',
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
                  text: 'Top News',
                ),
                Tab(
                  text: 'Recent',
                ),
                Tab(
                  text: 'World',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [TopNews(), Recent(), World()],
          ),
        ),
      ),
    );
  }
}
