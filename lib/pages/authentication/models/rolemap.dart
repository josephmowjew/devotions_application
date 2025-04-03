import 'package:devotions_app/shared/models/authentication/login_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rolemap.g.dart';

@JsonSerializable()
class Rolemap {
  @JsonKey(name: "roleMapId")
  int? roleMapId;
  @JsonKey(name: "organisationalId")
  int? organisationalId;
  @JsonKey(name: "branchId")
  String? branchId;
  @JsonKey(name: "role")
  Role? role;

  Rolemap({this.roleMapId, this.organisationalId, this.branchId, this.role});

  factory Rolemap.fromJson(Map<String, dynamic> json) =>
      _$RolemapFromJson(json);

  Map<String, dynamic> toJson() => _$RolemapToJson(this);
}
