import 'package:flutter/cupertino.dart';

abstract class HomeNavigationModel {
  String name = '';

  String badge();

  String serverSideName();

  String get getName => name;

  String get serverName => serverSideName();

  String get getBadge => badge();

  IconData icon();

  HomeNavigationEnum value();

  Widget page();

  IconData get getIcon => icon();
  void setName(String name){
    this.name = name;
  }
}

enum HomeNavigationEnum {
  profile,
  examTarget,
  exam,
  messages,
  workBookInNavigation,
  workBook,
  easyQuestion;
}
