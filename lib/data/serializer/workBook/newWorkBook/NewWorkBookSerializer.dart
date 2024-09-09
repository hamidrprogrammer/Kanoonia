import 'dart:convert';
NewWorkBookSerializer newWorkBookSerializerFromJson(String str) => NewWorkBookSerializer.fromJson(json.decode(str));
String newWorkBookSerializerToJson(NewWorkBookSerializer data) => json.encode(data.toJson());
class NewWorkBookSerializer {
  NewWorkBookSerializer({
      this.wordBookPdfLink, 
      this.workBorkPdfStatus, 
      this.wordBookIsMessage,});

  NewWorkBookSerializer.fromJson(dynamic json) {
    wordBookPdfLink = json['wordBookPdfLink'];
    workBorkPdfStatus = json['workBorkPdfStatus'];
    wordBookIsMessage = json['wordBookIsMessage'];
  }
  String? wordBookPdfLink;
  String? workBorkPdfStatus;
  String? wordBookIsMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wordBookPdfLink'] = wordBookPdfLink;
    map['workBorkPdfStatus'] = workBorkPdfStatus;
    map['wordBookIsMessage'] = wordBookIsMessage;
    return map;
  }

}