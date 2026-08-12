import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/chat/chat_service.dart';

class ChatRepository {
  final ChatService _chatService;

  ChatRepository(this._chatService);

  Future<void> sendMessage(String receiverID, String message) {
    return _chatService.sendMessage(receiverID, message);
  }

  Stream<List<Message>> getMessages(String otherUserID) {
    return _chatService.getMessages(otherUserID);
  }

  Stream<List<UserModel>> getUsers() {
    return _chatService.getUserStream();
  }

  Future<void> sendTypingStatus(String receiverID, bool isTyping) {
    return _chatService.sendTypingStatus(receiverID, isTyping);
  }

  Stream<bool> getTypingStream(String otherUserID) {
    return _chatService.getTypingStream(otherUserID);
  }
}
