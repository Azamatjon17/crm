import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String phone;
  final String password;
  final String passwordConfirmation;

  SignUpEvent(this.name, this.phone, this.password, this.passwordConfirmation);

  @override
  List<Object> get props => [name, phone, password, passwordConfirmation];
}

class SignInEvent extends AuthEvent {
  final String phone;
  final String password;

  SignInEvent(this.phone, this.password);

  @override
  List<Object> get props => [phone, password];
}

class CheckAuthStatusEvent extends AuthEvent {}
