import 'package:chat_app/core/di/di.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/widgets/app_textfield.dart';
import 'package:chat_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/cubit/chat_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.user});
  final UserModel user;
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return BlocProvider(
      create: (context) => sl<ChatCubit>()..getMessages(user.uid),
      child: BlocBuilder<ChatCubit, ChatStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.userName ?? ""),
                  if (state.isOtherUserTyping)
                    Text(
                      "typing...",
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.messages?.length ?? 0,
                    itemBuilder: (context, index) {
                      final message = state.messages![index];
                      final isMe = message.senderID == currentUserId;
                      final time = DateFormat(
                        'h:mm a',
                      ).format(message.createdAt.toDate());
                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 12.0,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                isMe ? "You" : (user.userName ?? ""),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: isMe
                                      ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                            .withValues(alpha: 0.7)
                                      : Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withValues(alpha: 0.7),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      message.message,
                                      style: TextStyle(
                                        color: isMe
                                            ? Theme.of(context).colorScheme.onPrimary
                                            : Theme.of(
                                                context,
                                              ).colorScheme.onSecondary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: isMe
                                          ? Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withValues(alpha: 0.7)
                                          : Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                                .withValues(alpha: 0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25,
                    left: 8,
                    right: 8,
                    top: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          hintText: "Enter Your Message",
                          controller: _messageController,
                          onChanged: (value) {
                            context.read<ChatCubit>().sendTypingStatus(
                              user.uid,
                              value,
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_messageController.text.trim().isNotEmpty) {
                            context.read<ChatCubit>().sendMessage(
                              user.uid,
                              _messageController.text.trim(),
                            );
                            _messageController.clear();
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
