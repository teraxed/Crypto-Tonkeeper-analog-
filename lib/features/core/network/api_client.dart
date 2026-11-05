import 'package:dio/dio.dart';

abstract class ApiClient {
  // TODO: адрес своего бэка (Android-эмулятор: 10.0.2.2 вместо localhost)
  static const String baseUrl = 'http://localhost:8000/api';

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}