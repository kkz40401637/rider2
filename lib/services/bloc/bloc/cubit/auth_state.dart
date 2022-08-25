part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginResponseModel response;
  LoginSuccess(this.response);
  @override
  List<Object> get props => [response];
}

class LoginFail extends AuthState {
  final String error;
  LoginFail(this.error);

  @override
  List<Object> get props => [error];
}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}
