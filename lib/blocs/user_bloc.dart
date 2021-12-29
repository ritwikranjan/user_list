import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_list/events/user_events.dart';
import 'package:user_list/models/user_model.dart';
import 'package:user_list/repository/user_repository.dart';
import 'package:user_list/states/user_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UsersUninitialized()) {
    on<FetchUsersEvent>((event, emit) async {
      emit(UsersLoading());
      try {
        final List<User> users = await UserRepository().getUsersFromDb();
        emit(UsersLoaded(users: users));
      } catch (e) {
        emit(UsersError(error: e.toString()));
      }
    });
    on<RefreshUsersEvent>((event, emit) async {
      emit(UsersLoading());
      try {
        await UserRepository().persistUsersFromAPI();
        final List<User> users = await UserRepository().getUsersFromDb();
        emit(UsersLoaded(users: users));
      } catch (e) {
        emit(UsersError(error: e.toString()));
      }
    });
  }
}
