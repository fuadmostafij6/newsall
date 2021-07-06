import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Health extends StatefulWidget {
  const Health({key}) : super(key: key);

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  Future getPost() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('world_covid').getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Word Covid info'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: getPost(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SpinKitPumpingHeart(
                  color: Colors.redAccent,
                ));
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.all(5.0)),
                          Text(
                            'Symptoms',
                            style:
                                TextStyle(fontSize: 24.0, color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SymptomCard(
                                  image: snapshot.data[index].data['headache'],
                                  title: "Headache",
                                ),
                                SymptomCard(
                                  image: snapshot.data[index].data['caugh'],
                                  title: "Caugh",
                                ),
                                SymptomCard(
                                  image: snapshot.data[index].data['fever'],
                                  title: "Fever",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'World',
                            style:
                                TextStyle(fontSize: 24.0, color: Colors.white),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Counter(
                                color: Colors.orangeAccent,
                                number: snapshot.data[index].data['case'],
                                title: 'Infected',
                              ),
                              Counter(
                                color: Colors.redAccent,
                                number: snapshot.data[index].data['death'],
                                title: 'Deaths',
                              ),
                              Counter(
                                color: Colors.green,
                                number: snapshot.data[index].data['recovered'],
                                title: 'Recovered',
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  const Counter({
    Key key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6.0),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: color,
                  width: 2,
                )),
          ),
        ),
        SizedBox(height: 10),
        Text(
          '$number',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        Text(
          title,
          style: TextStyle(color: color),
        )
      ],
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Colors.orangeAccent,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: Colors.orangeAccent,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.network(image, height: 70),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
