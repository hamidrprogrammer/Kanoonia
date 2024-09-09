import 'package:core/network/response/KanoonHttpResponse.dart';
import 'package:kanooniha/data/serializer/BaseSerializer.dart';

extension ResponseExtension on KanoonHttpResponse {

  BaseSerializer get result => baseSerializerFromJson(body);
}

extension BaseResponseExtensions on BaseSerializer {
  bool get isSuccessFull => success == true;

  String get errorMessage => message ?? '';
}
