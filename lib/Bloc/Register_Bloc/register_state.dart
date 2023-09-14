part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {}

class CreateUserSuccessState extends RegisterState {
  final String uId;

  CreateUserSuccessState(this.uId);
}

class CreateUserErrorState extends RegisterState {}

class ChangePasswordVisibilityState extends RegisterState {}
