part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uId;
  LoginSuccessState({required this.uId});
}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {}

class ChangePasswordVisibilityState extends LoginState {}
