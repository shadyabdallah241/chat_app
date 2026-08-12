import 'dart:async';

import 'package:chat_app/features/chat/cubit/chat_states.dart';
import 'package:chat_app/features/chat/repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit({required this._chatRepository})
    : super(const ChatStates(status: ChatStatus.initial));

  final ChatRepository _chatRepository;

  StreamSubscription? _messagesSubscription;
  StreamSubscription<bool>? _typingSubscription;

  void getMessages(String otherUserID) {
    emit(state.copyWith(status: ChatStatus.loading));

    _messagesSubscription?.cancel();
    _typingSubscription?.cancel();

    _messagesSubscription = _chatRepository
        .getMessages(otherUserID)
        .listen(
          (messages) {
            emit(
              state.copyWith(status: ChatStatus.success, messages: messages),
            );
          },
          onError: (error) {
            emit(
              state.copyWith(
                status: ChatStatus.failure,
                errorMessage: error.toString(),
              ),
            );
          },
        );

    _typingSubscription = _chatRepository.getTypingStream(otherUserID).listen(
      (isTyping) {
        emit(state.copyWith(isOtherUserTyping: isTyping));
      },
    );
  }

  void sendTypingStatus(String receiverID, String text) {
    final isTyping = text.trim().isNotEmpty;
    _chatRepository.sendTypingStatus(receiverID, isTyping);
  }

  Future<void> sendMessage(String receiverID, String message) async {
    try {
      await _chatRepository.sendMessage(receiverID, message);
      await _chatRepository.sendTypingStatus(receiverID, false);
      emit(state.copyWith(status: ChatStatus.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: ChatStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _typingSubscription?.cancel();
    return super.close();
  }
}
