import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
    @JsonKey(name: "token")
    String token;
    @JsonKey(name: "accessTicket")
    AccessTicket accessTicket;

    LoginResponse({
        required this.token,
        required this.accessTicket,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

    Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class AccessTicket {
    @JsonKey(name: "sub")
    String sub;
    @JsonKey(name: "username")
    String username;
    @JsonKey(name: "employeeId")
    String employeeId;
    @JsonKey(name: "firstName")
    String firstName;
    @JsonKey(name: "lastName")
    String lastName;
    @JsonKey(name: "phoneNumber")
    String phoneNumber;
    @JsonKey(name: "enabled")
    bool enabled;
    @JsonKey(name: "pendingReset")
    bool pendingReset;
    @JsonKey(name: "roles")
    List<Role> roles;
    @JsonKey(name: "iat")
    int iat;
    @JsonKey(name: "exp")
    int exp;

    AccessTicket({
        required this.sub,
        required this.username,
        required this.employeeId,
        required this.firstName,
        required this.lastName,
        required this.phoneNumber,
        required this.enabled,
        required this.pendingReset,
        required this.roles,
        required this.iat,
        required this.exp,
    });

    factory AccessTicket.fromJson(Map<String, dynamic> json) => _$AccessTicketFromJson(json);

    Map<String, dynamic> toJson() => _$AccessTicketToJson(this);
}

@JsonSerializable()
class Role {
    @JsonKey(name: "roleId")
    String roleId;
    @JsonKey(name: "branchId")
    String branchId;
    @JsonKey(name: "organisationalId")
    String organisationalId;

    Role({
        required this.roleId,
        required this.branchId,
        required this.organisationalId,
    });

    factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

    Map<String, dynamic> toJson() => _$RoleToJson(this);
}
