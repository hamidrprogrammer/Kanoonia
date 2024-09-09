import 'dart:convert';
/// Status : 1
/// Data : {"state":1,"message":"کارنامه با موفقیت دریافت شد","downloadLink":"https://app1.kanoon.ir/HtmToPdf/PdfFile/cb305305cc654e5a807cf1ec956a34a0"}
/// Message : ""

GetWorkBookResponse getWorkBookResponseFromJson(String str) => GetWorkBookResponse.fromJson(json.decode(str));
String getWorkBookResponseToJson(GetWorkBookResponse data) => json.encode(data.toJson());
class GetWorkBookResponse {
  GetWorkBookResponse({
      num? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetWorkBookResponse.fromJson(dynamic json) {
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
/// message : "کارنامه با موفقیت دریافت شد"
/// downloadLink : "https://app1.kanoon.ir/HtmToPdf/PdfFile/cb305305cc654e5a807cf1ec956a34a0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? state, 
      String? message, 
      String? downloadLink,}){
    _state = state;
    _message = message;
    _downloadLink = downloadLink;
}

  Data.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    _downloadLink = json['downloadLink'];
  }
  num? _state;
  String? _message;
  String? _downloadLink;

  num? get state => _state;
  String? get message => _message;
  String? get downloadLink => _downloadLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    map['downloadLink'] = _downloadLink;
    return map;
  }

}