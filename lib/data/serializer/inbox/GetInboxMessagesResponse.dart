import 'dart:convert';
/// Status : 1
/// Data : {"state":1,"message":"جستجوی پیام ها با موفقیت انجام شد","InboxMessages":[{"Id":3,"Title":"testTitle","Description":"testDescription","ImageUrl":"","LinkUrl":"","InsertDate":"چهارشنبه 29 بهمن 1399","hasSeen":true,"hasLiked":false}]}
/// Message : ""

GetInboxMessagesResponse getInboxMessagesResponseFromJson(String str) => GetInboxMessagesResponse.fromJson(json.decode(str));
String getInboxMessagesResponseToJson(GetInboxMessagesResponse data) => json.encode(data.toJson());
class GetInboxMessagesResponse {
  GetInboxMessagesResponse({
      num? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetInboxMessagesResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    _message = json['Message'];
  }
  num? _status;
  Data? _data;
  String? _message;

  num? get status => _status;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    if (_data != null) {
      map['Data'] = _data?.toJson();
    }
    map['Message'] = _message;
    return map;
  }

}

/// state : 1
/// message : "جستجوی پیام ها با موفقیت انجام شد"
/// InboxMessages : [{"Id":3,"Title":"testTitle","Description":"testDescription","ImageUrl":"","LinkUrl":"","InsertDate":"چهارشنبه 29 بهمن 1399","hasSeen":true,"hasLiked":false}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? state, 
      String? message, 
      List<InboxMessages>? inboxMessages,}){
    _state = state;
    _message = message;
    _inboxMessages = inboxMessages;
}

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    if (json['InboxMessages'] != null) {
      _inboxMessages = [];
      json['InboxMessages'].forEach((v) {
        _inboxMessages?.add(InboxMessages.fromJson(v));
      });
    }
  }
  num? _state;
  String? _message;
  List<InboxMessages>? _inboxMessages;

  num? get state => _state;
  String? get message => _message;
  List<InboxMessages>? get inboxMessages => _inboxMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_inboxMessages != null) {
      map['InboxMessages'] = _inboxMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Id : 3
/// Title : "testTitle"
/// Description : "testDescription"
/// ImageUrl : ""
/// LinkUrl : ""
/// InsertDate : "چهارشنبه 29 بهمن 1399"
/// hasSeen : true
/// hasLiked : false

InboxMessages inboxMessagesFromJson(String str) => InboxMessages.fromJson(json.decode(str));
String inboxMessagesToJson(InboxMessages data) => json.encode(data.toJson());
class InboxMessages {
  InboxMessages({
      num? id, 
      String? title, 
      String? description, 
      String? imageUrl, 
      String? linkUrl, 
      String? insertDate, 
      bool? hasSeen, 
      bool? hasLiked,}){
    _id = id;
    _title = title;
    _description = description;
    _imageUrl = imageUrl;
    _linkUrl = linkUrl;
    _insertDate = insertDate;
    _hasSeen = hasSeen;
    _hasLiked = hasLiked;
}

  InboxMessages.fromJson(dynamic json) {
    _id = json['Id'];
    _title = json['Title'];
    _description = json['Description'];
    _imageUrl = json['ImageUrl'];
    _linkUrl = json['LinkUrl'];
    _insertDate = json['InsertDate'];
    _hasSeen = json['hasSeen'];
    _hasLiked = json['hasLiked'];
  }
  num? _id;
  String? _title;
  String? _description;
  String? _imageUrl;
  String? _linkUrl;
  String? _insertDate;
  bool? _hasSeen;
  bool? _hasLiked;

  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get imageUrl => _imageUrl;
  String? get linkUrl => _linkUrl;
  String? get insertDate => _insertDate;
  bool? get hasSeen => _hasSeen;
  bool? get hasLiked => _hasLiked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['Title'] = _title;
    map['Description'] = _description;
    map['ImageUrl'] = _imageUrl;
    map['LinkUrl'] = _linkUrl;
    map['InsertDate'] = _insertDate;
    map['hasSeen'] = _hasSeen;
    map['hasLiked'] = _hasLiked;
    return map;
  }

}