import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:devotions_app/core/errors/api_exception.dart';
import 'package:devotions_app/core/errors/exceptions.dart';
import 'package:devotions_app/shared/models/authentication/account_locked_dto.dart';
import 'package:devotions_app/shared/models/authentication/auth_modals.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_provider/authentication_provider.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_urls.dart';
import 'package:devotions_app/shared/utils/http_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProviderImpl implements AuthenticationProvider {
  final http.Client client;

  AuthenticationProviderImpl({required this.client});

  @override
  Future<LoginResponse> loginUser(LoginDto login) async {
    final url = Uri.parse(AuthenticationUrls.login);

    var response = await HttpUtils.post(url, client, body: login.toJson());

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return LoginResponse.fromJson(jsonResponse);
    }
    // else if (response.statusCode == 202) {
    //   throw ServerException('2fa_code_sent');
    // }
    else if (response.statusCode == 401) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      LoginError error = LoginError.fromJson(jsonResponse);
      throw ServerException(error.message);
    } else if (response.statusCode == 423) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      AccountLockedDto error = AccountLockedDto.fromJson(jsonResponse);
      throw ServerException(error.message ?? '');
    } else {
      throw ServerException(response.body);
    }
  }

  @override
  Future<String?> getToken() async {
    const secureStorage = FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    String? token;
    token =
        kIsWeb
            ? prefs.getString('accessToken')
            : await secureStorage.read(key: 'accessToken');
    return token;
  }

  @override
  Future saveToken(LoginResponse response) async {
    const secureStorage = FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();

    if (kIsWeb) {
      await prefs.setString('accessToken', response.token);
      await prefs.setString("loggedInUser", jsonEncode(response.accessTicket));
    } else {
      await secureStorage.write(key: 'accessToken', value: response.token);
      await secureStorage.write(
        key: 'loggedInUser',
        value: jsonEncode(response.accessTicket),
      );
    }
    // kIsWeb
    //     ? prefs.setString('accessToken', response.token)
    //     : await secureStorage.write(key: 'accessToken', value: response.token);
  }

  @override
  Future<String> changePassword(ChangePasswordDto changePasswordDto) async {
    final url = Uri.parse(AuthenticationUrls.changePassword);

    var response = await HttpUtils.put(
      url,
      client,
      body: changePasswordDto.toJson(),
    );

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      final String jsonResponse = response.body;
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      throw ApiException.fromJson(jsonResponse);
    }
  }

  @override
  Future<String?> forgotPassword(String username) async {
    final url = Uri.parse('${AuthenticationUrls.forgotPasswod}$username');

    var response = await HttpUtils.get(url, client);

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      final String jsonResponse = response.body;
      return jsonResponse;
    } else {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      throw ApiException.fromJson(jsonResponse);
    }
  }

  @override
  Future<String?> resetPassword(
    String token,
    ResetPasswordDto resetPasswordDto,
  ) async {
    final url = Uri.parse(
      '${AuthenticationUrls.restPassword}?resetToken=$token',
    );

    var response = await HttpUtils.post(
      url,
      client,
      body: resetPasswordDto.toJson(),
    );

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      return response.body;
    } else {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      ApiException error = ApiException.fromJson(jsonResponse);
      throw ServerException(error.errorDescription ?? '');
    }
  }

  @override
  Future<LoginResponse> twoFactorCode(TwoFactorDto twoFactorDto) async {
    final url = Uri.parse(
      '${AuthenticationUrls.twoFactor}?username=${twoFactorDto.username}&securityCode=${twoFactorDto.securityCode}',
    );

    var response = await HttpUtils.get(url, client);

    log(" ->> ${response.body}");
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return LoginResponse.fromJson(jsonResponse);
    } else {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      ApiException error = ApiException.fromJson(jsonResponse);
      throw ServerException(error.errorDescription ?? '');
    }
  }

  @override
  Future<UserProfile> getUserProfile() async {
    final url = Uri.parse(AuthenticationUrls.getUserProfile);

    var response = await HttpUtils.get(url, client);

    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return UserProfile.fromJson(jsonResponse);
    } else {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      ApiException error = ApiException.fromJson(jsonResponse);
      throw ServerException(error.errorDescription ?? '');
    }
  }
}
