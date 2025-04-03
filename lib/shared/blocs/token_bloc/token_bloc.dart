import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_state.dart';
import 'package:devotions_app/shared/models/authentication/auth_modals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenCubit extends Cubit<TokenState> {
  TokenCubit() : super(const TokenState()) {
    // Load token on initialization
    loadTokenAndBranch();
  }

  Future<void> loadTokenAndBranch() async {
    dev.log("🔐 TokenCubit: Loading token and branch");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    final branch = prefs.getString('branch');
    final orgId = prefs.getInt('organisationId');
    final username = prefs.getString('username');
    final userData = prefs.getString("loggedInUser");
    final utcOffset = prefs.getInt('utcOffset');
    final user =
        (userData != null) ? AccessTicket.fromJson(jsonDecode(userData)) : null;

    // Log values for debugging
    dev.log(
      "🔐 TokenCubit - token: ${token != null ? 'exists (${token.length} chars)' : 'null'}",
    );
    dev.log("🔐 TokenCubit - branch: $branch");
    dev.log("🔐 TokenCubit - orgId: $orgId");
    dev.log("🔐 TokenCubit - username: $username");

    emit(
      state.copyWith(
        token: token,
        branch: branch,
        orgId: orgId,
        username: username,
        user: user,
        utcOffset: utcOffset,
      ),
    );

    // Additional debugging
    dev.log(
      "🔐 TokenCubit - State updated - token exists: ${state.token != null}",
    );
  }

  Future<void> saveToken(
    String token,
    String branchId,
    int orgId,
    String name,
    AccessTicket user,
  ) async {
    dev.log(
      "🔐 TokenCubit: Saving token - branch: $branchId, orgId: $orgId, name: $name",
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    await prefs.setInt('organisationId', orgId);
    await prefs.setString('branch', branchId);
    await prefs.setString('username', name);
    await prefs.setString("loggedInUser", jsonEncode(user));
    emit(
      state.copyWith(
        token: token,
        orgId: orgId,
        branch: branchId,
        username: name,
      ),
    );
    dev.log("🔐 TokenCubit: Token saved successfully");
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('branch');
    await prefs.remove('organisationId');
    await prefs.remove('loggedInUser');
    await prefs.remove('utcOffset');

    emit(const TokenState());
  }
}
