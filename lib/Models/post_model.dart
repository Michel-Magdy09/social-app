import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String name;
  String uId;
  String userImage;
  String dateTime;
  String text;
  String postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.userImage,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  factory PostModel.fromJson(jsonData) {
    return PostModel(
      name: jsonData['name'],
      text: jsonData['text'],
      postImage: jsonData['postImage'],
      dateTime: jsonData['dateTime'],
      userImage: jsonData['userImage'],
      uId: jsonData['uId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'postImage': postImage,
      'dateTime': dateTime,
      'userImage': userImage,
      'uId': uId,
    };
  }

  factory PostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return PostModel(
        name: data?['name'],
        text: data?['text'],
        postImage: data?['postImage'],
        dateTime: data?['dateTime'],
        userImage: data?['userImage'],
        uId: data?['uId']);
  }
}
