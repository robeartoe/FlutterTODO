import 'package:flutter/material.dart';
import 'package:WhatTodo/API.dart';
import 'package:WhatTodo/item.dart';
import 'dart:convert';
import 'todoWidget.dart';
import 'dart:developer';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'What to do'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var items = new List<Item>();

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems(){
    API.getItems().then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        items = list.map((model) => Item.fromJson(model)).toList();
      });
    });
  }

  // TODO: Add items. With the button(bottom right) to a new screen, and to post it to server.
  void postItem() {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (BuildContext context, _, __) {
          return new todoWidget();
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new SlideTransition(position: Tween<Offset>(
              begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(
              animation), child: child,);






          /*FadeTransition(
            opacity: animation,
            child: new RotationTransition(
              turns: new Tween<double>(begin: 0.0, end: 0.0).animate(animation),
              child: child,
            ),
          );*/
        }
    ));
  }


  Widget _buildTodolist() {
     return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context,index){
        return ListTile(title: Text(items[index].content));
      },
    );
  }

  Widget _buildTodoItem(){
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildTodolist(),
        floatingActionButton: new FloatingActionButton(
          onPressed: postItem,
          tooltip: 'Add task',
          child: new Icon(Icons.add)
        ),
    );
  }
}
