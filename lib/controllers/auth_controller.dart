import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final dio = Dio();
  String baseUrl = 'http://millima.flutterwithakmaljon.uz/api';
  siginUp(String name, String password, String phone,
      String passwordConfirmation) async {
    final response = await dio.post(
      '$baseUrl/register',
      data: {
        'name': name,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation
      },
    );

    print(response);
  }

  siginIn(String phone, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/login',
        data: {
          'phone': phone,
          'password': password,
        },
      );
      print(response);
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
