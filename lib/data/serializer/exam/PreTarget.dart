import 'dart:convert';
PreTarget preTargetFromJson(String str) => PreTarget.fromJson(json.decode(str));
String preTargetToJson(PreTarget data) => json.encode(data.toJson());
class PreTarget {
  PreTarget({
      this.id, 
      this.userId, 
      this.testDate, 
      this.groupCode, 
      this.courseId, 
      this.targetPercent, 
      this.targetIndex, 
      this.insertDate,});

  PreTarget.fromJson(dynamic json) {
    id = json['Id'];
    userId = json['UserId'];
    testDate = json['TestDate'];
    groupCode = json['GroupCode'];
    courseId = json['CourseId'];
    targetPercent = json['TargetPercent'];
    targetIndex = json['TargetIndex'];
    insertDate = json['InsertDate'];
  }
  num? id;
  num? userId;
  num? testDate;
  num? groupCode;
  num? courseId;
  num? targetPercent;
  num? targetIndex;
  String? insertDate;
PreTarget copyWith({  num? id,
  num? userId,
  num? testDate,
  num? groupCode,
  num? courseId,
  num? targetPercent,
  num? targetIndex,
  String? insertDate,
}) => PreTarget(  id: id ?? this.id,
  userId: userId ?? this.userId,
  testDate: testDate ?? this.testDate,
  groupCode: groupCode ?? this.groupCode,
  courseId: courseId ?? this.courseId,
  targetPercent: targetPercent ?? this.targetPercent,
  targetIndex: targetIndex ?? this.targetIndex,
  insertDate: insertDate ?? this.insertDate,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['UserId'] = userId;
    map['TestDate'] = testDate;
    map['GroupCode'] = groupCode;
    map['CourseId'] = courseId;
    map['TargetPercent'] = targetPercent;
    map['TargetIndex'] = targetIndex;
    map['InsertDate'] = insertDate;
    return map;
  }

}