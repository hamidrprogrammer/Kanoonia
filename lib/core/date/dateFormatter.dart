import 'package:persian_number_utility/persian_number_utility.dart';

extension DateFormatter on String? {
  String? get toPerDate =>
      DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(toString().extractNumber().toEnglishDigit()) ?? 0)
          .toPersianDate();
}
