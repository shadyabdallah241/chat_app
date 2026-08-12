import 'package:chat_app/core/di/di.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/widgets/app_textfield.dart';
import 'package:chat_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/cubit/chat_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                                      ? Colors.white70
                                      : Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withValues(alpha: 0.7),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                message.message,
                                style: TextStyle(
                                  color: isMe
                                      ? Colors.white
                                      : Theme.of(
                                          context,
                                        ).colorScheme.onSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
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
