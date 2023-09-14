part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetUserDataLoadingState extends HomeState {}

class GetUserDataSuccessState extends HomeState {}

class GetUserDataErrorState extends HomeState {}
