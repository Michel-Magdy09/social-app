import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String phone;
  String email;
  String uId;
  String image;
  String cover;
  String bio;
  bool isEmailVerified;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.uId,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      email: jsonData['email'],
      name: jsonData['name'],
      phone: jsonData['phone'],
      uId: jsonData['uId'],
      image: jsonData['image'],
      cover: jsonData['cover'],
      bio: jsonData['bio'],
      isEmailVerified: jsonData['isEmailVerified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
        name: data?["name"],
        phone: data?["phone"],
        email: data?["email"],
        uId: data?["uId"],
        image: data?["image"],
        cover: data?["cover"],
        bio: data?["bio"],
        isEmailVerified: data?["isEmailVerified"]);
  }
}
