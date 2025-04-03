import 'package:devotions_app/shared/models/authentication/auth_modals.dart';

class TokenState {
  final String? token;
  final String? branch;
  final int? orgId;
  final String? username;
  final AccessTicket? user;
  final int? utcOffset;

  const TokenState({
    this.token,
    this.branch,
    this.orgId,
    this.username,
    this.user,
    this.utcOffset,
  });

  TokenState copyWith({
    String? token,
    String? branch,
    int? orgId,
    String? username,
    AccessTicket? user,
    int? utcOffset,
  }) {
    return TokenState(
      token: token ?? this.token,
      branch: branch ?? this.branch,
      orgId: orgId ?? this.orgId,
      username: username ?? this.username,
      user: user ?? this.user,
      utcOffset: utcOffset ?? this.utcOffset,
    );
  }
}
