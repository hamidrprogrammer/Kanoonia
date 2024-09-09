import 'dart:convert';
VersionCheckSerializer versionCheckSerializerFromJson(String str) => VersionCheckSerializer.fromJson(json.decode(str));
String versionCheckSerializerToJson(VersionCheckSerializer data) => json.encode(data.toJson());
class VersionCheckSerializer {
  VersionCheckSerializer({
      this.status, 
      this.message, 
      this.isForceUpdate,
      this.link,});

  VersionCheckSerializer.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    link = json['link'];
    isForceUpdate = json['isForceUpdate'];
  }
  num? status;
  String? message;
  String? link;
  bool? isForceUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['link'] = link;
    return map;
  }

}