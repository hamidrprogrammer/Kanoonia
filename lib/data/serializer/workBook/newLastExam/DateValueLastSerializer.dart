import 'dart:convert';

import 'package:kanooniha/data/serializer/workBook/nextExam/DateValueNextSerializer.dart';
DateValueLastSerializer dateValueLastSerializerFromJson(String str) => DateValueLastSerializer.fromJson(json.decode(str));
String dateValueLastSerializerToJson(DateValueLastSerializer data) => json.encode(data.toJson());
class DateValueLastSerializer {
  DateValueLastSerializer({
      this.isShow, 
      this.dateValue, 
      this.dateValuePersian, 
      this.totalLevel, 
      this.totalRank,});

  DateValueLastSerializer.fromJson(dynamic json) {
    isShow = json['isShow'];
    dateValue = json['dateValue'];
    dateValuePersian = json['dateValuePersian'];
    title = json['title'];
    totalLevel = json['totalLevel'];
    totalRank = json['totalRank'];
  }
  bool? isShow;
  num? dateValue;
  String? dateValuePersian;
  String? title;
  num? totalLevel;
  num? totalRank;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isShow'] = isShow;
    map['dateValue'] = dateValue;
    map['dateValuePersian'] = dateValuePersian;
    map['totalLevel'] = totalLevel;
    map['totalRank'] = totalRank;
    return map;
  }

  DateValueNextSerializer toNextValue(){
    return DateValueNextSerializer(
      dateValue: dateValue,
      dateValuePersian: dateValuePersian,
      remainingDays: 7
    );
  }

}

