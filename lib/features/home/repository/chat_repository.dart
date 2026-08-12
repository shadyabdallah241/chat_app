import 'dart:async';

import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/chat/chat_service.dart';

class ChatRepository {
  final ChatService _chatService;

  ChatRepository(this._chatService);
  Stream<List<UserModel>> getUsers() {
    return _chatService.getUserStream();
  }
}
