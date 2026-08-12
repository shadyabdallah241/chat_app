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

    await _firestore.collection("chat_rooms").doc(chatRoomID).set(
      {
        "typing_${currentUser.uid}": false,
      },
      SetOptions(merge: true),
    );
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

  Future<void> sendTypingStatus(String receiverID, bool isTyping) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final ids = [currentUser.uid, receiverID]..sort();
    final chatRoomID = ids.join("_");

    await _firestore.collection("chat_rooms").doc(chatRoomID).set(
      {
        "typing_${currentUser.uid}": isTyping,
      },
      SetOptions(merge: true),
    );
  }

  Stream<bool> getTypingStream(String otherUserID) {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return Stream.value(false);

    final ids = [currentUser.uid, otherUserID]..sort();
    final chatRoomID = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return false;
      final data = snapshot.data()!;
      return data["typing_$otherUserID"] == true;
    });
  }
}
