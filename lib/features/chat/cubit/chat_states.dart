import 'package:chat_app/core/models/message.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus { initial, loading, success, failure, typing }

class ChatStates extends Equatable {
  final ChatStatus status;
  final List<Message>? messages;
  final String? errorMessage;

  const ChatStates({required this.status, this.messages, this.errorMessage});

  ChatStates copyWith({
    ChatStatus? status,
    List<Message>? messages = const [],
    String? errorMessage,
  }) {
    return ChatStates(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, messages, errorMessage];
}
