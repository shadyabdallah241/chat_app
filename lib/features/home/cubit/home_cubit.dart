import 'dart:async';

import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/features/home/repository/chat_repository.dart';
import 'package:chat_app/features/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final ChatRepository chatRepository;
  HomeCubit(this.chatRepository) : super(HomeStates(status: .initial));
  StreamSubscription<List<UserModel>>? _usersSubscription;

  void getUsers() {
    emit(state.copyWith(status: .loading));
    _usersSubscription = chatRepository.getUsers().listen(
      (users) {
        emit(state.copyWith(status: .success, users: users));
      },
      onError: (error) {
        emit(state.copyWith(status: .failure, errorMessage: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}
