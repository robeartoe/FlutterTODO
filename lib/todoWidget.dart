
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'item.dart';
import 'package:WhatTodo/API.dart';
import 'package:flutter/foundation.dart';

import 'main.dart';

class TodoState extends State<todoWidget>{
  final formKey = GlobalKey<FormState>();
  final noteController = TextEditingController();
  String note;

  //Item myItem = new Item(content);

  _postItem(){
    String data = noteController.text;
    if(data.isEmpty){
      _emptyItem();
      return;
    }
    API.postItem(data).then((response){

      var item = json.decode(response.body);
      // debugPrint(item.toString());

      var value = json.encode({
        'id' : item['post_id'],
        'content' : data
      });

      // debugPrint(value.toString());

      Navigator.pop(context,value);
    });
  }
  void _emptyItem(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Field can not be empty'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('OKAY'),
                    onPressed: () => Navigator.of(context).pop()
                )
              ]
          );
        }
    );
  }
  @override
  Widget build(BuildContext context){
    final Size screenSize = MediaQuery.of(context).size;
    final myController = TextEditingController();

    return new Scaffold(
      appBar: AppBar(
        title: new Text('Enter Task'),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
                  TextFormField(
                    controller: noteController,
                    decoration: InputDecoration(
                      labelText: 'Add Task',
                      labelStyle: TextStyle(
                        fontSize: 20
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.0)
                    ),
                    style: TextStyle(
                      fontSize: 40
                    ),
                  ),
                  new Container(
                    width: screenSize.width,
                    child: new RaisedButton(
                      child: new Text(
                        'Add Note',
                        style: new TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: _postItem,
                      color: Colors.blue,
                    ),
                    margin: new EdgeInsets.only(
                      top: 20.0
                    ),
                  ),
                ],
          )
        ),
      ),
    );
  }
}
class todoWidget extends StatefulWidget{
  @override
  createState() => new TodoState();
}