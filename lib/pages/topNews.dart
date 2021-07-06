import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:newsphobia/details/topDetails.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class TopNews extends StatefulWidget {
  @override
  _TopNewsState createState() => _TopNewsState();
}

class _TopNewsState extends State<TopNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _BuildListView(),
    );
  }
}

class _BuildListView extends StatefulWidget {
  @override
  __BuildListViewState createState() => __BuildListViewState();
}

class __BuildListViewState extends State<_BuildListView> {
  Future getPost() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('top').getDocuments();
    return qn.documents;
  }

  nav(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Drecent(
                  post: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getPost(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitPumpingHeart(
                color: Colors.redAccent,
              ),
            );
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return SingleChildScrollView(
                    child:
                        // ListTile(
                        //   title: Image.network(snapshot.data[index].data['img']),
                        //   subtitle: Text(snapshot.data[index].data['tittle']),
                        //   onTap: () {
                        //     nav(snapshot.data[index]);
                        //   },
                        // ),
                        InkWell(
                            onTap: () {
                              nav(snapshot.data[index]);
                            },
                            child: Card(
                              color: Colors.black,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Ink.image(
                                        image: NetworkImage(
                                            snapshot.data[index].data['img']),
                                        height: 240,
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          Colors.grey,
                                          BlendMode.darken,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            snapshot.data[index].data['tittle'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'Bison',
                                              fontSize: 24,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50.0,
                                          ),
                                          SingleChildScrollView(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                      .data['author'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Icon(Icons.timer,
                                                    color: Colors.white),
                                                Text(
                                                  timeago
                                                      .format(
                                                        DateTime.tryParse(
                                                          snapshot.data[index]
                                                              .data['time']
                                                              .toDate()
                                                              .toString(),
                                                        ),
                                                      )
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                            // child: Card(
                            //   elevation: 2.0,
                            //   margin: EdgeInsets.only(bottom: 20.0),
                            //   child: SingleChildScrollView(
                            //     child: Column(
                            //       children: [
                            //         Container(
                            //           constraints: BoxConstraints.expand(
                            //             height: 200.0,
                            //           ),
                            //           decoration: BoxDecoration(color: Colors.grey),
                            //           child: Image.network(
                            //             snapshot.data[index].data['img'],
                            //             fit: BoxFit.cover,
                            //           ),
                            //           // height: 100,
                            //           // width: 100,
                            //           // decoration: BoxDecoration(
                            //           //     image: DecorationImage(
                            //           //         image: NetworkImage(
                            //           //             snapshot.data[index].data['img']),
                            //           //         fit: BoxFit.cover),
                            //           //     borderRadius: BorderRadius.circular(8.0)),
                            //         ),
                            //         SizedBox(
                            //           width: 5.0,
                            //         ),
                            //         Expanded(
                            //             child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: <Widget>[
                            //             Text(
                            //               snapshot.data[index].data['tittle'],
                            //               style: TextStyle(fontSize: 14.0),
                            //             ),
                            //             SizedBox(
                            //               width: 12.0,
                            //             ),
                            //             SingleChildScrollView(
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceAround,
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: <Widget>[
                            //                   Icon(Icons.person),
                            //                   Text(
                            //                     snapshot.data[index].data['author'],
                            //                   ),
                            //                   SizedBox(
                            //                     width: 1.0,
                            //                   ),
                            //                   Icon(Icons.timer),
                            //                   Text(
                            //                     timeago
                            //                         .format(
                            //                           DateTime.tryParse(
                            //                             snapshot
                            //                                 .data[index].data['time']
                            //                                 .toDate()
                            //                                 .toString(),
                            //                           ),
                            //                         )
                            //                         .toString(),
                            //                     style: TextStyle(
                            //                         color: Colors.blueAccent,
                            //                         fontSize: 15),
                            //                   ),
                            //                 ],
                            //               ),
                            //             )
                            //           ],
                            //         ))
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            ),
                  );
                });
          }
        },
      ),
    );
  }
}
