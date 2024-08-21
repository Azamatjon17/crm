import 'package:crm/bloc/auth_bloc/auth_bloc.dart';
import 'package:crm/bloc/auth_bloc/auth_event.dart';
import 'package:crm/bloc/auth_bloc/auth_state.dart';
import 'package:crm/ui/screens/home_screen.dart';
import 'package:crm/ui/screens/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final dio = Dio();
  runApp(MyApp(dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;

  const MyApp(this.dio, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(dio)..add(CheckAuthStatusEvent()),
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomeScreen();
            } else if (state is Unauthenticated) {
              return const LoginScreen();
            } else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
