import 'package:chat_app/core/models/user.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.userName ?? "")),
      body: Center(
        child: Column(children: [Text(user.email), Text(user.userName ?? "")]),
      ),
    );
  }
}
