import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? userName;
  const UserModel({required this.uid, required this.email, this.userName});
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: data['uid'] ?? doc.id,
      email: data['email'] ?? '',
      userName: data['userName'],
    );
  }
}
