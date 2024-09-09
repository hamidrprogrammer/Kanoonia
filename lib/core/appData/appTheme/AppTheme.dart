import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';

import '../../../common/ui/WidgetSize.dart';

class AppTheme {
  static ThemeData myTheme() {
    return ThemeData(
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedIconColor: Colors.white,
        collapsedTextColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        iconColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.white, fontFamily: 'dana'),
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(buttonColor: Colors.blue, padding: 8.dpev),
      // scaffoldBackgroundColor: ViewConsts.backGroundColor,
      scaffoldBackgroundColor: Colors.grey.shade100,
      useMaterial3: false,
      primaryColorDark: Colors.blue,
      fontFamily: 'dana',
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade50,
          centerTitle: true,
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0.5),
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      inputDecorationTheme: InputDecorationTheme(
        focusColor: Colors.blue,
        contentPadding: const EdgeInsets.all(8.0),
        filled: false,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(WidgetSize.textFieldRadiusSize),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(WidgetSize.textFieldRadiusSize),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WidgetSize.textFieldRadiusSize),
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(WidgetSize.elevatedButtonPaddingSize),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'dana',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
    );
  }
}
