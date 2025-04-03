import 'package:json_annotation/json_annotation.dart';

part 'account_locked_dto.g.dart';
@JsonSerializable()
class AccountLockedDto {
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "message")
    String? message;

    AccountLockedDto({
        this.status,
        this.message,
    });

    factory AccountLockedDto.fromJson(Map<String, dynamic> json) => _$AccountLockedDtoFromJson(json);

    Map<String, dynamic> toJson() => _$AccountLockedDtoToJson(this);
}
