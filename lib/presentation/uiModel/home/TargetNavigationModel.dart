import 'package:flutter/material.dart';
import 'package:kanooniha/presentation/ui/exam/TargetPageUi.dart';

import 'HomeNavigationModel.dart';

class TargetNavigationModel extends HomeNavigationModel {
  @override
  String badge() {
    return '';
  }

  @override
  IconData icon() {
    return Icons.add_chart_rounded;
  }

  @override
  String name = 'هدف گذاری';


  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.examTarget;
  }

  @override
  Widget page() => const TargetPageUi();

  @override
  String serverSideName() => '';
}
