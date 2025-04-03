import 'package:json_annotation/json_annotation.dart';

part 'two_factor_dto.g.dart';
@JsonSerializable()
class TwoFactorDto {
    @JsonKey(name: "username")
    String username;
    @JsonKey(name: "securityCode")
    String securityCode;

    TwoFactorDto({
        required this.username,
        required this.securityCode,
    });

    factory TwoFactorDto.fromJson(Map<String, dynamic> json) => _$TwoFactorDtoFromJson(json);

    Map<String, dynamic> toJson() => _$TwoFactorDtoToJson(this);
}
