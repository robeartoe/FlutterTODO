import 'package:flutter/material.dart';
import 'package:WhatTodo/API.dart';
import 'package:WhatTodo/item.dart';
import 'dart:convert';
import 'todoWidget.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';

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
      home: MyHomePage(title: 'What To Do'),
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
  ScrollController _controller;

  _scrollListener(){
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
          _getItems();
    }
  }

  @override
  void initState() {
    _controller = ScrollController(initialScrollOffset: 50);
    _controller.addListener(_scrollListener);
    _getItems();
    super.initState();
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Mark "${items[index].content}" as done?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('MARK AS DONE'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  void _removeTodoItem(int index) {
    // Remove from DB:
    API.deleteItem(items[index]).then((response){
        setState(() => items.removeAt(index));
    });
  }

  _getItems(){
    API.getItems().then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        items = list.map((model) => Item.fromJson(model)).toList();
      });
    });
  }

  void postItem() {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext) {
          return new todoWidget();
      },
      maintainState: true,
        // maintainState: true,
        // opaque: true,
        // transitionDuration: const Duration(milliseconds: 250),
        // pageBuilder: (BuildContext context, _, __) {
        // },
        // transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        //   return new SlideTransition(position: Tween<Offset>(
        //       begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(
        //       animation), child: child,);
        // }
    ));
  }


  Widget _buildTodolist() {
      // _controller.addListener(_scrollListener);
      return new ListView.builder(
        controller: _controller,
        itemCount: items.length,
        itemBuilder: (context, index){
          return _buildTodoItem(items[index].content, index);
        },
    );
  }

  Widget _buildTodoItem(String content, int index){
    return new ListTile(
      title: Text(items[index].content),
      onTap: () => _promptRemoveTodoItem(index)
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(children: <Widget>[
          _buildTodolist(),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
            heroTag: 'Add',
            onPressed: postItem,
            tooltip: 'Add task',
            child: new Icon(Icons.add), 
          )),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              heroTag: 'Refresh',
              onPressed: _getItems,
              tooltip: 'Refresh Task',
              child: new Icon(Icons.refresh)
            )

          ),
      ]),

        //   floatingActionButton: new FloatingActionButton(
        //   onPressed: postItem,
        //   tooltip: 'Add task',
        //   child: new Icon(Icons.add)
        // ),

    );
  }
}
