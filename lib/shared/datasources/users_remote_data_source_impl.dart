import 'dart:convert';
import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/constrants/user_notes_urls.dart';
import 'package:http/http.dart' as http;
import 'package:devotions_app/shared/models/user.dart';
import 'users_remote_data_source.dart';

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final http.Client client;

  UsersRemoteDataSourceImpl({required this.client});

  @override
  Future<List<User>> getAllUsers() async {
    final url = Uri.parse(UserNotesUrls.getAllUsers);
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((item) => User.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Failed to get users: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }
}
