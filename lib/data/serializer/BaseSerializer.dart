import 'dart:convert';

BaseSerializer baseSerializerFromJson(String str) =>
    BaseSerializer.fromJson(json.decode(str));

String baseSerializerToJson(BaseSerializer data) => json.encode(data.toJson());

class BaseSerializer {
  BaseSerializer({
    this.data,
    this.message,
    this.success,
    this.status,
  });

  BaseSerializer.fromJson(dynamic json) {
    data = json['data'] != null ? jsonEncode(json['data']) : null;
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  dynamic data;
  String? message;
  bool? success;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['message'] = message;
    map['success'] = success;
    map['status'] = status;
    return map;
  }
}
