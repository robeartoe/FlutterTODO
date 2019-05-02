class Item {
  String id;
  String content;
  DateTime date;

  Item (String id, String content){
    this.id = id;
    this.content = content;
    // this.date = date;
  }

  Item.fromJson(Map json) :
      id = json['_id']['\$oid'],
      content = json['content'];
      // date = new DateTime.fromMicrosecondsSinceEpoch(json['date']['\$date']);

  Map toJson(){
    return {'content':content,'id':id};
  }
}