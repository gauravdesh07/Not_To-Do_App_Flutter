import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'nottodoscreen.dart';

class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Not-To Do App"),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      body: new NotToDoScreen(),
    );
  }
}