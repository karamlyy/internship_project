import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:language_learning/data/Interceptor/refresh_token_interceptor.dart';
import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/data/endpoint/file/upload_file_endpoint.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/base/response_model.dart';
import 'package:language_learning/data/Interceptor/authority_interceptor.dart';
import 'package:language_learning/data/Interceptor/logging_interceptor.dart';
import 'package:language_learning/data/service/preferences/preferences.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';
import 'package:retry/retry.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options
      ..baseUrl = ApiRoutes.baseUrl
      ..contentType = "application/json-patch+json"
      ..headers = {};

    // Added optimizations for faster connection and retries
    _dio.options
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 5);

    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(AuthorityInterceptor(dio: _dio));
    _dio.interceptors.add(RefreshTokenInterceptor(_dio));
  }

  // Set shorter retry delays to quickly retry failed requests
  final _retryOptions = const RetryOptions(
    maxAttempts: 2,
    delayFactor: Duration(milliseconds: 500), // Reduced delay factor
  );

  Future<Either<HttpException, T>> task<T>(Endpoint endpoint) async {
    try {
      final result = await _retryOptions.retry(
            () => _executeRequest(endpoint),
        retryIf: (e) => e is DioException && _shouldRetry(e),
      );
      return Right(await _handle<T>(result));
    } on DioException catch (e) {
      return Left(await _handleError(e));
    }
  }

  Future<Response> _executeRequest(Endpoint endpoint) async {
    final options = Options(headers: endpoint.headers);
    switch (endpoint.httpMethod) {
      case HttpMethod.get:
        return _dio.get(
          endpoint.route,
          options: options,
          queryParameters: endpoint.queryParameters,
        );
      case HttpMethod.post:
        return _dio.post(
          endpoint.route,
          options: options,
          data: endpoint.body,
          queryParameters: endpoint.queryParameters,
        );
      case HttpMethod.put:
        return _dio.put(
          endpoint.route,
          options: options,
          data: endpoint.body,
          queryParameters: endpoint.queryParameters,
        );
      case HttpMethod.delete:
        return _dio.delete(
          endpoint.route,
          options: options,
          data: endpoint.body,
          queryParameters: endpoint.queryParameters,
        );
    }
  }

  Future<dynamic> _handle<T>(Response response) async {
    if ([200, 201, 203, 204].contains(response.statusCode)) {
      final request = ResponseModel<T>.fromJson(response.data);

      if (request.isSuccessful && request.hasData) {
        return request.data;
      } else if (request.isSuccessful && !request.hasData) {
        return request.message;
      } else {
        return HttpException(error: ErrorMessage(message: request.message ?? "", code: request.status));
      }
    } else {
      return HttpException(
        error: ErrorMessage(message: response.statusMessage ?? "Unknown error", code: response.statusCode),
      );
    }
  }

  Future<HttpException> _handleError(DioException e) async {
    if (e.error != null && e.error is HttpException) {
      return e.error as HttpException;
    }

    String errorMessage = "Unknown error occurred";
    int? statusCode = e.response?.statusCode;

    if (e.response?.data is Map<String, dynamic>) {
      final data = e.response?.data as Map<String, dynamic>;
      if (data.containsKey('errors') && (data['errors'] as List).isNotEmpty) {
        errorMessage = data['errors'][0]?.toString() ?? errorMessage;
      } else if (data.containsKey('message')) {
        errorMessage = data['message']?.toString() ?? errorMessage;
      }
    } else if (e.message != null) {
      errorMessage = e.message ?? errorMessage;
    }

    return HttpException(
      error: ErrorMessage(message: errorMessage, code: statusCode),
    );
  }

  // Reduced retries to improve response speed in case of failures
  bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout;
  }

  Future<Either<HttpException, T>> uploadFile<T>(UploadFileEndpoint endpoint) async {
    try {
      final result = await _retryOptions.retry(
            () async => _dio.post(
          endpoint.route,
          data: await endpoint.formData,
          queryParameters: endpoint.queryParameters,
          options: Options(contentType: "multipart/form-data"),
        ),
        retryIf: (e) => e is DioException && _shouldRetry(e),
      );
      return Right(await _handle<T>(result));
    } on DioException catch (e) {
      return Left(await _handleError(e));
    }
  }

  Future<String?> getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    return await messaging.getToken();
  }

  Future<void> saveFcmToken() async {
    final prefs = await PreferencesService.instance;
    final token = await getFcmToken();

    if (token != null) {
      await prefs.setFcmToken(token);
    }
  }
}