import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHeaders {
  static Future<Map<String, String>> get headers async {
    const secureStorage = FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    String? token;
    token =
        kIsWeb
            ? prefs.getString('accessToken')
            : await secureStorage.read(key: 'accessToken');
    final tokenCubit = TokenCubit();
    await tokenCubit.loadTokenAndBranch();
    final apiToken = token;
    log(" BR ${tokenCubit.state.branch} ${tokenCubit.state.orgId} $apiToken");
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiToken',
      "branchId": tokenCubit.state.branch.toString(),
      "organisationId": tokenCubit.state.orgId.toString(),
    };
  }
}
