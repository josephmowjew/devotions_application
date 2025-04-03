import 'package:devotions_app/pages/authentication/models/rolemap.dart';
import 'package:devotions_app/shared/models/authentication/config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  @JsonKey(name: "emailAddress")
  String? emailAddress;
  @JsonKey(name: "employeeId")
  String? employeeId;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "enabled")
  bool? enabled;
  @JsonKey(name: "disabledDate")
  dynamic disabledDate;
  @JsonKey(name: "is_locked")
  dynamic isLocked;
  @JsonKey(name: "deletedAt")
  dynamic deletedAt;
  @JsonKey(name: "config")
  Config? config;
  @JsonKey(name: "rolemaps")
  List<Rolemap>? rolemaps;

  UserProfile({
    this.emailAddress,
    this.employeeId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.enabled,
    this.disabledDate,
    this.isLocked,
    this.deletedAt,
    this.config,
    this.rolemaps,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
