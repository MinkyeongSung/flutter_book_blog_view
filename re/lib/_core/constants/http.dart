import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: "http://192.168.0.20:8080", // 내 IP 입력
    contentType: "application/json; charset=utf-8",
  ),
);

const secureStorage = FlutterSecureStorage();
