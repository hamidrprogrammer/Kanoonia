import 'package:core/network/response/KanoonHttpResponse.dart';
import 'package:dio/dio.dart';

abstract class KanoonHttpRequests {
  Future<KanoonHttpResponse> get(Uri uri);

  Future<KanoonHttpResponse> post(Uri uri, {Object? data});

  Future<Response<dynamic>> request(String path, {Object? data, Map<String,
      dynamic>? queryParameters, Options? options,});
}
