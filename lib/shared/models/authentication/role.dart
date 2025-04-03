import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class Role {
    @JsonKey(name: "roleId")
    String? roleId;
    @JsonKey(name: "description")
    String? description;

    Role({
        this.roleId,
        this.description,
    });

    factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

    Map<String, dynamic> toJson() => _$RoleToJson(this);
}
