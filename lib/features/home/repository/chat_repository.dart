import 'dart:async';

import 'package:chat_app/core/services/chat/chat_service.dart';

class ChatRepository {
  final ChatService _chatService;

  ChatRepository(this._chatService);
  Stream<List<Map<String, dynamic>>> getUsers() {
    return _chatService.getUserStream();
  }
}
