// This file handles all the GETS, DELETES, and POST information.abstract
import 'dart:async';
import 'package:http/http.dart' as http;

class API {
  static Future getItems(){
    var url = "http://localhost:5000/api/items";
    return http.get(url);
  }

  static Future postItem(){
    var url = 'http://localhost:5000/api/submit';
    
  }

  

}