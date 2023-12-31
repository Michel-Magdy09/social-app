import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/Models/message_model.dart';
import 'package:socialapp/Screens/chat_screens.dart';
import 'package:socialapp/Screens/feeds_screen.dart';
import 'package:socialapp/Screens/new_post_screen.dart';
import 'package:socialapp/Screens/settings_screen.dart';
import 'package:socialapp/Screens/users_screen.dart';

import '../../Models/post_model.dart';
import '../../Models/user_model.dart';
import '../../Shared/Network/Local/cache_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void getUserData() async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .where("uId", isEqualTo: CacheHelper.getData(key: 'UserDocId'))
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
    if (index == 1) {
      getAllUsers();
    }
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

////////create new post
  var postImage;

  Future pickPostImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print("No Post image selected");
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  UploadTask? uploadPostImageTask;
  String postImageUrl = '';

  void uploadPostImage({
    required String dateTime,
    required String postText,
  }) async {
    emit(CreatePostLoadingState());
    final path = 'posts/${Uri.file(postImage.path).pathSegments.last}';
    final file = File(postImage.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadPostImageTask = ref.putFile(file);
    await uploadPostImageTask?.whenComplete(() async {
      postImageUrl = await ref.getDownloadURL();
      createNewPost(
        dateTime: dateTime,
        postText: postText,
        postImage: postImageUrl,
      );
    }).catchError((error) {
      print("UploadProfileImageErrorState :$error");
      emit(CreatePostErrorState());
    });
  }

  void createNewPost({
    required String dateTime,
    required String postText,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    final newPost = {
      'userName': userModel?.name,
      'uId': userModel?.uId,
      'userImage': userModel?.image,
      'dateTime': dateTime,
      'text': postText,
      'postImage': postImage ?? '',
    };
    posts.add(newPost).then((value) {
      postsList.add(PostModel.fromJson(newPost));
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print("CreatePostErrorState: $error");
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> postsList = [];
  List<String> postsIds = [];
  List<int> likesList = [];
  final posts = FirebaseFirestore.instance.collection('posts');

  void getPosts() async {
    emit(GetAllPostsLoadingState());
    await posts.get().then((value) {
      postsList = [];
      postsIds = [];
      likesList = [];
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likesList.add(value.docs.length);
          postsIds.add(element.id);
          postsList.add(PostModel.fromJson(element.data()));
          emit(GetAllPostsSuccessState());
        }).catchError((error) {
          emit(GetAllPostsErrorState());
        });
      });
    }).catchError((error) {
      emit(GetAllPostsErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uId)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  List<UserModel> allUsersModel = [];

  void getAllUsers() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      allUsersModel = [];
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel?.uId) {
          allUsersModel.add(UserModel.fromJson(element.data()));
        }
      });
      emit(GetAllUsersDataSuccessState());
    }).catchError((error) {
      emit(GetAllUsersDataErrorState());
    });
  }

  void sendMessages({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
        senderId: userModel!.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    }).catchError((error) {
      print(error.toString());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<MessageModel> messagesList = [];
  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      messagesList = [];
      event.docs.forEach((element) {
        messagesList.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
    });
  }
}
