import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class User extends StatelessWidget{
  String _itemName;
  String _dateCreated;
  int _id;

  User(this._itemName,this._dateCreated);

  User.map(dynamic obj){
    this._dateCreated=obj["dateCreated"];
    this._itemName=obj["itemName"];
    this._id=obj["id"];
  }

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();
    map["itemName"]=this._itemName;
    map["dateCreated"]=this._dateCreated;

//    if(_id!=null)
      map["id"]=this._id;

    return map;
  }

  User.fromMap(Map<String,dynamic> map){
    this._itemName=map['itemName'];
    this._id=map["id"];
    this._dateCreated=map["dateCreated"];
  }
  String get itemName => _itemName;

  set itemName(String value) {
    _itemName = value;
  }

  String get dateCreated => _dateCreated;

  set dateCreated(String value) {
    _dateCreated = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: const EdgeInsets.all(15),
      child: new Column(
        children: <Widget>[
          new Text(_itemName
            ,style: new TextStyle(
            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.9)
            ,),
          new Container(
            margin: const EdgeInsets.only(top: 5),
            child: new Text(
              "Created on $_dateCreated",
              style: new TextStyle(color: Colors.white38,fontStyle: FontStyle.italic,fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }


}