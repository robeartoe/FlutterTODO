// This file handles all the GETS, DELETES, and POST information.abstract
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:WhatTodo/item.dart';

class API {
  static Future getItems(){
    const String url = 'http://localhost:5000/api/items';
    return http.get(url);
  }

  static Future postItem(String item){
    const String url = 'http://localhost:5000/api/submit';
    final Map<String,String> data = {'content':item};
    return http.post(url,body: json.encode(data),headers: {'content-type' : 'application/json',
        'accept' : 'application/json',});
  }

  static Future deleteItem(Item item){
    final String url = 'http://localhost:5000/api/delete/${item.id}';
    return http.delete(url);
  }
}