import 'package:core/network/interceptor/KanoonHttoInterceptor.dart';
import 'package:core/network/kanoonHttp/KanoonHttpRequests.dart';
import 'package:core/network/kanoonHttp/shared_adapter.dart';
import 'package:core/network/response/KanoonHttpResponse.dart';
import 'package:dio/dio.dart';

class KanoonDio with DioMixin implements Dio {
  KanoonDio(
      {BaseOptions? baseOptions,
      bool logEnable = false,
      Map<String, String>? extraHeaders}) {
    options = baseOptions ?? BaseOptions();
    httpClientAdapter = getAdapter();
    if (logEnable) {
      interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    if (extraHeaders != null && extraHeaders.isNotEmpty) {
      options.headers.addAll(extraHeaders);
    }
  }
}

class KanoonHttp implements KanoonHttpRequests {
  KanoonDio kanoonDio;

  KanoonHttp(this.kanoonDio);

  @override
  Future<KanoonHttpResponse> get(Uri uri) async {
    return (await kanoonDio.getUri(uri)).createKanoonResponse;
  }

  @override
  Future<KanoonHttpResponse> post(Uri uri, {Object? data}) async {
    return (await kanoonDio.postUri(uri, data: data)).createKanoonResponse;
  }

  void addInterceptor(KanoonHttpInterceptor interceptor) {
    if (!kanoonDio.interceptors.contains(interceptor)) {
      kanoonDio.interceptors.add(interceptor);
    }
  }

  @override
  Future<Response<dynamic>> request(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return kanoonDio.request(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
  }
}
