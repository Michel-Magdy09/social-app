import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String phone;
  String email;
  String uId;
  bool isEmailVerified;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.uId,
    required this.isEmailVerified,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      email: jsonData['email'],
      name: jsonData['name'],
      phone: jsonData['phone'],
      uId: jsonData['uId'],
      isEmailVerified: jsonData['isEmailVerified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
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
        isEmailVerified: data?["isEmailVerified"]);
  }
}
