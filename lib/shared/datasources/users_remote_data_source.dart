import 'package:devotions_app/shared/models/user.dart';

abstract class UsersRemoteDataSource {
  Future<List<User>> getAllUsers();
}
