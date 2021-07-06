

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Drecent extends StatefulWidget {
  final DocumentSnapshot post;
  Drecent({this.post});
  @override
  _DrecentState createState() => _DrecentState();
}

class _DrecentState extends State<Drecent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(widget.post.data['tittle']),
      ),
    );
  }
}
