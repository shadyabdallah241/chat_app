import 'package:chat_app/core/di/di.dart';
import 'package:chat_app/core/widgets/app_drawer.dart';
import 'package:chat_app/features/chat/chat_page.dart';
import 'package:chat_app/features/home/cubit/home_cubit.dart';
import 'package:chat_app/features/home/cubit/home_state.dart';
import 'package:chat_app/features/login/cubit/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<HomeCubit>()..getUsers()),
        BlocProvider(create: (context) => sl<LoginCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.read<LoginCubit>().signout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            if (state.status == .initial) {
              return const SizedBox();
            }
            if (state.status == .loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == .failure) {
              return Center(
                child: Text(state.errorMessage ?? "Something went wrong"),
              );
            }
            return ListView.builder(
              itemCount: state.users?.length ?? 0,
              itemBuilder: (context, index) {
                final user = state.users![index];
                return GestureDetector(
                  onTap: () {
                    debugPrint(
                      "CURRENT USER: ${FirebaseAuth.instance.currentUser!.uid}",
                    );
                    debugPrint("SELECTED USER: ${user.uid}");
                    debugPrint("SELECTED NAME: ${user.userName}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(user: user),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                    decoration: BoxDecoration(
                      color: theme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(user.userName ?? ""),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(user.email)],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
