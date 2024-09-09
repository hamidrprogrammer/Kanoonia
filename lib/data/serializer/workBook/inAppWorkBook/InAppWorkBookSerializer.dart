import 'dart:convert';
InAppWorkBookSerializer inAppWorkBookSerializerFromJson(String str) => InAppWorkBookSerializer.fromJson(json.decode(str));
String inAppWorkBookSerializerToJson(InAppWorkBookSerializer data) => json.encode(data.toJson());
class InAppWorkBookSerializer {
  InAppWorkBookSerializer({
      this.workBook,});

  InAppWorkBookSerializer.fromJson(dynamic json) {
    workBook = json['workBook'];
  }
  String? workBook;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['workBook'] = workBook;
    return map;
  }

}