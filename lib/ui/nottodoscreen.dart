import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_not_to_do/model/user.dart';
import 'package:flutter_app_not_to_do/util/DateFormat.dart';
import 'package:flutter_app_not_to_do/util/database_helper.dart';

class NotToDoScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new NotToDoScreenState();
  }
}

class NotToDoScreenState extends State<NotToDoScreen>{
  final TextEditingController _textEditingController=new TextEditingController();
  final List<User> items1=new List<User>();
  var db=  DatabaseHelper();

  void _handleSubmit(String text) async{
    _textEditingController.clear();
    User user=new User(text, dateFormatted());
    int savedItem=await db.saveUser(user);
    var addedItem=await db.getUser(savedItem);
    setState(() {
      items1.insert(0,addedItem);
    });
    print("Item Saved is $savedItem");
  }


  @override
  void initState() {
    super.initState();
    _readListItems();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: new FloatingActionButton(
        onPressed: _showFormDialog,
        elevation: 10,
        backgroundColor: Colors.redAccent,
        tooltip: "Add Item",
        child: new ListTile(
          title: new Icon(Icons.add),
        ),
      ),

      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8),
              reverse: false,
              itemBuilder:(BuildContext context,int index)
                {
                      return new Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.only(top: 5.0),
                        color: Colors.white38,
                        child: new ListTile(
                          onTap: (){
                            _updateNode(items1[index].itemName);
                            db.deleteUser(items1[index].id);
                            setState(() {
                              items1.removeAt(index);
                            });
                          },
                          title: items1[index],
                          leading: new CircleAvatar(
                            child: new Text("${items1[index].id}"),
                          ),
                          trailing: new IconButton(icon: new Icon(Icons.remove_circle,color: Colors.red,),
                              onPressed: (){
                            deleteNode(index);
                          }),
                        ),
                      );
                },
              itemCount: items1.length,
          ),
          ),
          new Divider(
            color: Colors.white70,
            height: 2.0,
          ),
        ],
      ),
    );
  }

  _showFormDialog() {
    var alert=new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(child: new TextField(autofocus: true,
            controller: _textEditingController,
            decoration: new InputDecoration(
              labelText: "Item",
              hintText: "e.g Don't Drink",
              icon: new Icon(Icons.note_add),
            ),
          )),
        ],
      ),
      actions: <Widget>[
        new FlatButton(onPressed:(){
          _handleSubmit(_textEditingController.text);
        },

            child: new Text("Save"),
        ),
        new FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: new Text("Cancel"),
    ),
      ],
    );
    showDialog(context: context,builder: (context){
      return alert;
    });
  }
  _readListItems() async{
    List items=await db.getAllUsers();
    items.forEach((item){
      setState(() {
        items1.add(User.map(item));
      });
//      User user=User.map(item);
//      print("DB Items:- ${user.itemName}");
    });
  }

  void deleteNode(int index) async {
    await db.deleteUser(items1[index].id);
    setState((){
      items1.removeAt(index);
    });
  }

  _updateNode(String itemName) {
    var alert=new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(child: new TextField(autofocus: true,
            controller: _textEditingController,
            decoration: new InputDecoration(
              labelText: "Item",
              counterText: itemName,
              icon: new Icon(Icons.note_add),
            ),
          )),
        ],
      ),
      actions: <Widget>[
        new FlatButton(onPressed:(){
          _handleSubmit(_textEditingController.text);
          Navigator.pop(context);
        },

          child: new Text("Save"),
        ),
        new FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: new Text("Cancel"),
        ),
      ],
    );
    showDialog(context: context,builder: (context){
      return alert;
    });
  }
}