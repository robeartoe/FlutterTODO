// This file handles all the GETS, DELETES, and POST information.abstract
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:WhatTodo/item.dart';
import 'package:flutter/foundation.dart';

class API {

  static Future getItems(){
    var url = "http://localhost:5000/api/items";
    return http.get(url);
  }

  static Future postItem(String item){
    var url = 'http://localhost:5000/api/submit';
    var data = {'content':item};
    return http.post(url,body: json.encode(data),headers: {"content-type" : "application/json",
        "accept" : "application/json",});
  }

  static Future deleteItem(Item item){
    var url = 'http://localhost:5000/api/delete/${item.id}';
    return http.delete(url);
  }
}