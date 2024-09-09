import 'package:flutter/cupertino.dart';

class ExamDetailUIModel {
  final String title, description;
  final IconData iconData;
  final Function() onClick;

  const ExamDetailUIModel({
    required this.title,
    required this.description,
    required this.iconData,
    required this.onClick,
  });
}
