part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetUserDataLoadingState extends HomeState {}

class GetUserDataSuccessState extends HomeState {}

class GetUserDataErrorState extends HomeState {}

class ChangeBottomNavIndexState extends HomeState {}

class AddPostIndexState extends HomeState {}

class ProfileImagePickedErrorState extends HomeState {}

class ProfileImagePickedSuccessState extends HomeState {}

class CoverImagePickedSuccessState extends HomeState {}

class CoverImagePickedErrorState extends HomeState {}

class UploadCoverImageErrorState extends HomeState {}

class UploadProfileImageErrorState extends HomeState {}

class UploadProfileImageSuccessState extends HomeState {}

class UploadCoverImageSuccessState extends HomeState {}

class UpdateUserDataErrorState extends HomeState {}

class UpdateUserDataLoadingState extends HomeState {}
