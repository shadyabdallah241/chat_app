import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp createdAt;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderID": senderID,
      "senderEmail": senderEmail,
      "receiverID": receiverID,
      "message": message,
      "createdAt": createdAt,
    };
  }

  factory Message.fromFirestore(Map<String, dynamic> map) {
    return Message(
      senderID: map["senderID"],
      senderEmail: map["senderEmail"],
      receiverID: map["receiverID"],
      message: map["message"],
      createdAt: map["createdAt"],
    );
  }
}
