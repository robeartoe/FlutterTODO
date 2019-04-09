
import 'package:flutter/material.dart';
import 'item.dart';
import 'main.dart';

class TodoState extends State<todoWidget>{
  final formKey = GlobalKey<FormState>();
  //Item myItem = new Item(content);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Enter Task'),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Task'
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
class todoWidget extends StatefulWidget{
  @override
  createState() => new TodoState();
}