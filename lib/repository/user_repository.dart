import 'package:user_list/database/database_provider.dart';
import 'package:user_list/models/user_model.dart';
import 'package:user_list/services/api_service.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._();
  factory UserRepository() => _instance;
  UserRepository._();

  final APIService _apiService = APIService();
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<void> persistUsersFromAPI() async {
    final List<User> users = await _apiService.getUserList();
    await _databaseProvider.insertUsers(users);
  }

  Future<List<User>> getUsersFromDb() async {
    final List<User> users = await _databaseProvider.getUsers();
    if (users.isEmpty) {
      await persistUsersFromAPI();
    }
    return await _databaseProvider.getUsers();
  }
}
