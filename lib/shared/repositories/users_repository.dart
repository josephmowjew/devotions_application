import 'package:devotions_app/shared/models/user.dart';

abstract class UsersRepository {
  Future<List<User>> getAllUsers();
}
