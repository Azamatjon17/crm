import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Dio dio;

  AuthBloc(this.dio) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await dio.post(
          'http://millima.flutterwithakmaljon.uz/api/register',
          data: {
            'name': event.name,
            'phone': event.phone,
            'password': event.password,
            'password_confirmation': event.passwordConfirmation,
          },
        );
        print(response);
        final token = response.data['data']['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError('Registration failed'));
      }
    });

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await dio.post(
          'http://millima.flutterwithakmaljon.uz/api/login',
          data: {
            'phone': event.phone,
            'password': event.password,
          },
        );
        final token = response.data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError('Login failed'));
      }
    });

    on<CheckAuthStatusEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
