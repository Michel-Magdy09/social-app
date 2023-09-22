import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String senderId;
  String receiverId;
  String dateTime;
  String text;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
  });

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      senderId: jsonData['senderId'],
      receiverId: jsonData['receiverId'],
      dateTime: jsonData['dateTime'],
      text: jsonData['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
    };
  }

  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return MessageModel(
      senderId: data?['senderId'],
      receiverId: data?['receiverId'],
      dateTime: data?['dateTime'],
      text: data?['text'],
    );
  }
}
