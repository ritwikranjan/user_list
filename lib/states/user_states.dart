import 'package:user_list/models/user_model.dart';

abstract class UserState {}

// State When the app Starts
class UsersUninitialized extends UserState {}

// State when user list is loading
class UsersLoading extends UserState {}

// State when user list is loaded
class UsersLoaded extends UserState {
  final List<User> users;
  UsersLoaded({required this.users});
}

// State when there is an error loading user list
class UsersError extends UserState {
  final String error;
  UsersError({required this.error});
}
