import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<UserModel>> getUserStream() {
    final currentUserId = _auth.currentUser?.uid;
    return _firestore
        .collection("Users")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromFirestore(doc))
              .where((user) => user.uid != currentUserId)
              .toList(),
        );
  }

  Future<void> sendMessage(String receiverID, String message) async {
    final currentUser = _auth.currentUser!;

    final newMessage = Message(
      senderID: currentUser.uid,
      senderEmail: currentUser.email!,
      receiverID: receiverID,
      message: message,
      createdAt: Timestamp.now(),
    );

    final ids = [currentUser.uid, receiverID]..sort();
    final chatRoomID = ids.join("_");

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<List<Message>> getMessages(String otherUserID) {
    final currentUser = _auth.currentUser!;
    debugPrint("🔥 SEND MESSAGE CALLED");

    final ids = [currentUser.uid, otherUserID]..sort();
    final chatRoomID = ids.join("_");
    debugPrint("MY UID: ${currentUser.uid}");
    debugPrint("OTHER UID: $otherUserID");
    debugPrint("CHAT ROOM: $chatRoomID");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("createdAt", descending: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Message.fromFirestore(doc.data()))
              .toList(),
        );
  }
}
