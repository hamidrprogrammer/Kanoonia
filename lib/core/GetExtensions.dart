import 'package:get/get.dart';

class GetExtensions {
  static T? getArgs<T>() {
    if (Get.arguments != null && Get.arguments is T) return Get.arguments as T;
    return null;
  }
}
