import 'package:json_annotation/json_annotation.dart';

part 'login_error.g.dart';
@JsonSerializable()
class LoginError {
    @JsonKey(name: "status")
    String status;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "attempts_remaining")
    String attemptsRemaining;

    LoginError({
        required this.status,
        required this.message,
        required this.attemptsRemaining,
    });

    factory LoginError.fromJson(Map<String, dynamic> json) => _$LoginErrorFromJson(json);

    Map<String, dynamic> toJson() => _$LoginErrorToJson(this);
}
