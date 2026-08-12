import 'package:chat_app/core/models/message.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus { initial, loading, success, failure }

class ChatStates extends Equatable {
  final ChatStatus status;
  final List<Message>? messages;
  final String? errorMessage;
  final bool isOtherUserTyping;

  const ChatStates({
    required this.status,
    this.messages,
    this.errorMessage,
    this.isOtherUserTyping = false,
  });

  ChatStates copyWith({
    ChatStatus? status,
    List<Message>? messages,
    String? errorMessage,
    bool? isOtherUserTyping,
  }) {
    return ChatStates(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      isOtherUserTyping: isOtherUserTyping ?? this.isOtherUserTyping,
    );
  }

  @override
  List<Object?> get props => [
        status,
        messages,
        errorMessage,
        isOtherUserTyping,
      ];
}
