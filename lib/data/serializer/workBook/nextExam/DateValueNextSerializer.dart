import 'dart:convert';
DateValueNextSerializer dateValueNextSerializerFromJson(String str) => DateValueNextSerializer.fromJson(json.decode(str));
String dateValueNextSerializerToJson(DateValueNextSerializer data) => json.encode(data.toJson());
class DateValueNextSerializer {
  DateValueNextSerializer({
      this.isShow,
      this.dateValue,
      this.dateValuePersian,
      this.remainingDays,
      this.remainingDaysText,});

  DateValueNextSerializer.fromJson(dynamic json) {
    isShow = json['isShow'];
    dateValue = json['dateValue'];
    title = json['title'];
    dateValuePersian = json['dateValuePersian'];
    remainingDays = json['remainingDays'];
    remainingDaysText = json['remainingDaysText'];
  }
  bool? isShow;
  num? dateValue;
  String? dateValuePersian;
  String? title;
  num? remainingDays;
  String? remainingDaysText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isShow'] = isShow;
    map['dateValue'] = dateValue;
    map['dateValuePersian'] = dateValuePersian;
    map['remainingDays'] = remainingDays;
    map['remainingDaysText'] = remainingDaysText;
    return map;
  }

}