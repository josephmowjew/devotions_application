import 'package:json_annotation/json_annotation.dart';

part 'change_password_dto.g.dart';

@JsonSerializable()
class ChangePasswordDto {
    @JsonKey(name: "oldPassword")
    String oldPassword;
    @JsonKey(name: "newPassword")
    String newPassword;

    ChangePasswordDto({
        required this.oldPassword,
        required this.newPassword,
    });

    factory ChangePasswordDto.fromJson(Map<String, dynamic> json) => _$ChangePasswordDtoFromJson(json);

    Map<String, dynamic> toJson() => _$ChangePasswordDtoToJson(this);
}
