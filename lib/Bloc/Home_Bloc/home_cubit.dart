import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/Screens/chat_screens.dart';
import 'package:socialapp/Screens/feeds_screen.dart';
import 'package:socialapp/Screens/new_post_screen.dart';
import 'package:socialapp/Screens/settings_screen.dart';
import 'package:socialapp/Screens/users_screen.dart';

import '../../Models/user_model.dart';
import '../../Shared/Network/Local/cache_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .where("uId", isEqualTo: CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      userModel = value.docs.map((e) => UserModel.fromSnapshot(e)).single;
      print(userModel?.uId);
      print(userModel?.email);
      print(userModel?.isEmailVerified);
      print(userModel?.name);
      print(userModel?.phone);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];
  List<String> title = ["Home", "Chat", "Add Post", " Users", "Settings"];
  void changeBottomNavIndex(index) {
    if (index == 2) {
      emit(AddPostIndexState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavIndexState());
    }
  }

  var profileImage;
  Future PickProfileImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print("No profile image selected");
      emit(ProfileImagePickedErrorState());
    }
  }

  var coverImage;
  Future PickCoverImageImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print("No cover image selected");
      emit(CoverImagePickedErrorState());
    }
  }

  UploadTask? uploadProfileImageTask;
  String profileImageUrl = '';
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(UpdateUserDataLoadingState());
    final path = 'images/${Uri.file(profileImage.path).pathSegments.last}';
    final file = File(profileImage.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadProfileImageTask = ref.putFile(file);
    await uploadProfileImageTask?.whenComplete(() async {
      profileImageUrl = await ref.getDownloadURL();
      updateUserInfo(
          name: name, phone: phone, bio: bio, image: profileImageUrl);
    }).catchError((error) {
      print("UploadProfileImageErrorState :$error");
      emit(UploadProfileImageErrorState());
    });
  }

  UploadTask? uploadCoverImageTask;
  String coverImageUrl = '';
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(UpdateUserDataLoadingState());
    final path = 'images/${Uri.file(coverImage.path).pathSegments.last}';
    final file = File(coverImage.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadCoverImageTask = ref.putFile(file);

    await uploadCoverImageTask?.whenComplete(() async {
      coverImageUrl = await ref.getDownloadURL();

      updateUserInfo(name: name, phone: phone, bio: bio, cover: coverImageUrl);
    }).catchError((error) {
      print("UploadCoverImageErrorState :$error");
      emit(UploadCoverImageErrorState());
    });
  }

  // Future<void> updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) async {
  //   //name,phone,bio,cover,profile
  //   emit(UpdateUserDataLoadingState());
  //   if (profileImage != null && coverImage != null) {
  //     uploadCoverImage();
  //     uploadProfileImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else {
  //     updateUserInfo(name: name, phone: phone, bio: bio);
  //   }
  // }

  Future<void> updateUserInfo(
      {required String name,
      required String phone,
      required String bio,
      String? cover,
      String? image}) async {
    emit(UpdateUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'UserDocId'))
        .update({
      'name': name,
      'phone': phone,
      'bio': bio,
      'cover': cover ?? userModel?.cover,
      'image': image ?? userModel?.image,
    }).then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }
}
