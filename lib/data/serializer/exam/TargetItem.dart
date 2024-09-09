import 'dart:convert';
/// CourseId : 1706
/// CourseName : "فيزيك 2- سوالات‌ موازي"
/// CoursePictureURL : "http://appservice.kanoon.ir/Files/Kanooniha/MyCourse/All/fizik.jpg"
/// TargetIndex : 5923
/// TargetPercent : 60

TargetItem targetItemFromJson(String str) => TargetItem.fromJson(json.decode(str));
String targetItemToJson(TargetItem data) => json.encode(data.toJson());
class TargetItem {
  TargetItem({
      num? courseId, 
      String? courseName, 
      String? coursePictureURL, 
      num? targetIndex, 
      num? targetPercent,}){
    _courseId = courseId;
    _courseName = courseName;
    _coursePictureURL = coursePictureURL;
    _targetIndex = targetIndex;
    _targetPercent = targetPercent;
}

  TargetItem.fromJson(dynamic json) {
    _courseId = json['CourseId'];
    _courseName = json['CourseName'];
    _coursePictureURL = json['CoursePictureURL'];
    _targetIndex = json['TargetIndex'];
    _targetPercent = json['TargetPercent'];
  }
  num? _courseId;
  String? _courseName;
  String? _coursePictureURL;
  num? _targetIndex;
  num? _targetPercent;

  num? get courseId => _courseId;
  String? get courseName => _courseName;
  String? get coursePictureURL => _coursePictureURL;
  num? get targetIndex => _targetIndex;
  num? get targetPercent => _targetPercent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CourseId'] = _courseId;
    map['CourseName'] = _courseName;
    map['CoursePictureURL'] = _coursePictureURL;
    map['TargetIndex'] = _targetIndex;
    map['TargetPercent'] = _targetPercent;
    return map;
  }

}