import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:language_learning/data/service/preferences/preferences.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class RefreshTokenInterceptor extends Interceptor {

  final Dio _dio;
  bool isRefreshing = false;

  List<Map<dynamic, dynamic>> failedRequests = [];

  RefreshTokenInterceptor(this._dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    if(err.response?.statusCode == 401) {

      final prefs = await PreferencesService.instance;

      if ((prefs.refreshToken ?? "").isEmpty) {
        await _clearSession();
        return handler.reject(err);
      }

      if (!isRefreshing) {

        isRefreshing = true;

        final refreshTokenResponse = await refreshToken(err, handler);
        if(refreshTokenResponse) {
          err.requestOptions.headers['Authorization'] ='Bearer ${prefs.accessToken}';
        } else {
          return handler.next(err);
        }
      } else {
        if (err.response?.data is Map<String, dynamic> && err.response?.data.containsKey('code') && err.requestOptions.path == ApiRoutes.refreshToken) {
          final errorCode = err.response?.data['code'];
          if (errorCode == 101) {
            isRefreshing = false;
            await _clearSession();
            return;
          }
        }
        failedRequests.add({'err': err, 'handler': handler});
      }
    } else {

      return handler.next(err);
    }
  }

  FutureOr refreshToken(DioException err, ErrorInterceptorHandler handler) async {
    final prefs = await PreferencesService.instance;
    final refreshToken = prefs.refreshToken;

    final refreshResponse = await _dio.post(
      ApiRoutes.refreshToken,
      data: {"refreshToken": refreshToken},
      options: Options(
        headers: {
          'Authorization': 'Bearer ${prefs.accessToken}',
          'Content-Type': 'application/json-patch+json'
        },
      ),
    );

    if (refreshResponse.statusCode == 401 || refreshResponse.statusCode == 403) {
      return false;
    }

    if(refreshResponse.statusCode == 200) {
      final newAccessToken = refreshResponse.data['data']["accessToken"];
      final newRefreshToken = refreshResponse.data['data']["refreshToken"];
      await prefs.setAccessToken(newAccessToken);
      await prefs.setRefreshToken(newRefreshToken);
      failedRequests.add({'err': err, 'handler': handler});
      await retryRequests(newAccessToken);
      return true;
    } else {
      isRefreshing = false;
      return false;
    }
  }

  Future retryRequests(token) async {
    for (var i = 0; i < failedRequests.length; i++) {
      RequestOptions requestOptions = failedRequests[i]['err'].requestOptions as RequestOptions;
      requestOptions.headers = {
        'Authorization': 'Bearer $token',
      };
      await _dio.fetch(requestOptions).then(
        failedRequests[i]['handler'].resolve,
        onError: (error) async {
          failedRequests[i]['handler'].reject(error as DioException);
        },
      );
    }
    isRefreshing = false;
    failedRequests = [];
  }

  Future<void> _clearSession() async {
    final prefs = await PreferencesService.instance;
    await prefs.clear();
    await prefs.setAuthorizationPassed(false);
    await prefs.setOnBoardingPassed(true);

    Navigation.pushNamedAndRemoveUntil(Routes.login, arguments: true);
    ScaffoldMessenger.of(Navigation.navigatorKey.currentContext!).showSnackBar(
      const SnackBar(
        content: Text("Sessiyanın vaxtı bitib. Zəhmət olmasa, yenidən daxil olun."),
      ),
    );
  }
}