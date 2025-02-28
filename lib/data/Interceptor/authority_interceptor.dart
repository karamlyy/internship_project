import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:language_learning/data/service/preferences/preferences.dart';

class AuthorityInterceptor extends Interceptor {
  final Dio dio;

  AuthorityInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await PreferencesService.instance;

    options.headers["accept"] = "*/*";
    options.headers["Accept-Encoding"] = "gzip, deflate, br";

    if (prefs.accessToken != null) {
      options.headers["Authorization"] = "Bearer ${prefs.accessToken}";
    }

    log("HEADERS: ${options.headers}");
    handler.next(options);
  }

}