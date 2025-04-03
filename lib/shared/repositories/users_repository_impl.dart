import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/datasources/users_remote_data_source.dart';
import 'package:devotions_app/shared/models/user.dart';
import 'users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<User>> getAllUsers() async {
    try {
      return await remoteDataSource.getAllUsers();
    } on ServerException {
      rethrow;
    }
  }
}
