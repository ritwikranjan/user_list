import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_list/blocs/user_bloc.dart';
import 'package:user_list/events/user_events.dart';
import 'package:user_list/states/user_states.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          // all four states possible is defined below. default is UsersUninitialized
          builder: (context, state) {
            if (state is UsersUninitialized) {
              BlocProvider.of<UserBloc>(context).add(FetchUsersEvent());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UsersError) {
              return const Center(
                child: Text('failed to fetch users'),
              );
            }
            if (state is UsersLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.users[index].name),
                    subtitle: Text(state.users[index].email),
                  );
                },
                itemCount: state.users.length,
              );
            }
            if (state is UsersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ),
        floatingActionButton: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UsersLoaded || state is UsersError) {
              return FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(RefreshUsersEvent());
                },
                child: const Icon(Icons.refresh),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
