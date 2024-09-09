import 'package:flutter/material.dart';

extension UiExtension on num {
  Widget get dp => Padding(padding: EdgeInsets.all(toDouble()));

  Widget get dph =>
      Padding(padding: EdgeInsets.symmetric(horizontal: toDouble()));

  Widget get dpv =>
      Padding(padding: EdgeInsets.symmetric(vertical: toDouble()));

  EdgeInsets get dpe => EdgeInsets.all(toDouble());
  EdgeInsets get dpev => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get dpeh => EdgeInsets.symmetric(horizontal: toDouble());
  Radius get radius => Radius.circular(toDouble());
  BorderRadius get bRadius => BorderRadius.circular(toDouble());
}