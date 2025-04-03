import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto {
    @JsonKey(name: "username")
    String username;
    @JsonKey(name: "password")
    String password;

    LoginDto({
        required this.username,
        required this.password,
    });

    factory LoginDto.fromJson(Map<String, dynamic> json) => _$LoginDtoFromJson(json);

    Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
