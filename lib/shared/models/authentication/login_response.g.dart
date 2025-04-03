// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String,
      accessTicket:
          AccessTicket.fromJson(json['accessTicket'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'accessTicket': instance.accessTicket,
    };

AccessTicket _$AccessTicketFromJson(Map<String, dynamic> json) => AccessTicket(
      sub: json['sub'] as String,
      username: json['username'] as String,
      employeeId: json['employeeId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      enabled: json['enabled'] as bool,
      pendingReset: json['pendingReset'] as bool,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      iat: (json['iat'] as num).toInt(),
      exp: (json['exp'] as num).toInt(),
    );

Map<String, dynamic> _$AccessTicketToJson(AccessTicket instance) =>
    <String, dynamic>{
      'sub': instance.sub,
      'username': instance.username,
      'employeeId': instance.employeeId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'enabled': instance.enabled,
      'pendingReset': instance.pendingReset,
      'roles': instance.roles,
      'iat': instance.iat,
      'exp': instance.exp,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      roleId: json['roleId'] as String,
      branchId: json['branchId'] as String,
      organisationalId: json['organisationalId'] as String,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'roleId': instance.roleId,
      'branchId': instance.branchId,
      'organisationalId': instance.organisationalId,
    };
