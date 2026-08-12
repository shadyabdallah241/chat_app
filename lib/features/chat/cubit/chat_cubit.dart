import 'dart:async';

import 'package:chat_app/features/chat/cubit/chat_states.dart';
import 'package:chat_app/features/chat/repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit({required this._chatRepository})
    : super(const ChatStates(status: ChatStatus.initial));

  final ChatRepository _chatRepository;

  StreamSubscription? _messagesSubscription;

  void getMessages(String otherUserID) {
    emit(state.copyWith(status: ChatStatus.loading));

    _messagesSubscription?.cancel();

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
  }

  void typing(String text) {
    if (text.trim().isEmpty) {
      emit(state.copyWith(status: ChatStatus.success));
    } else {
      emit(state.copyWith(status: ChatStatus.typing));
    }
  }

  Future<void> sendMessage(String receiverID, String message) async {
    try {
      await _chatRepository.sendMessage(receiverID, message);
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
    return super.close();
  }
}
