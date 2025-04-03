import 'package:json_annotation/json_annotation.dart';

part 'reset_password_dto.g.dart';

@JsonSerializable()
class ResetPasswordDto {
    
    @JsonKey(name: "password")
    String password;

    ResetPasswordDto({
        required this.password,
    });

    factory ResetPasswordDto.fromJson(Map<String, dynamic> json) => _$ResetPasswordDtoFromJson(json);

    Map<String, dynamic> toJson() => _$ResetPasswordDtoToJson(this);
}

