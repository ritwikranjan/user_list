// Singleton APIService Class
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:user_list/models/user_model.dart';

class APIService {
  static final APIService _instance = APIService._();
  factory APIService() => _instance;
  APIService._();

  // Base URL
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String userEndpoint = '$baseUrl/users';

  // Initialize Dio
  final Dio _dio = Dio();

  // Get User List
  Future<List<User>> getUserList() async {
    if (kDebugMode) {
      print('Fetching User List from public API');
    }
    try {
      final response = await _dio.get(userEndpoint);
      return (response.data as List).map((user) => User.fromJson(user)).toList();
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return List<User>.empty();
    }
  }
}
