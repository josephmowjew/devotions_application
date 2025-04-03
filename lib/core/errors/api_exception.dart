import 'package:json_annotation/json_annotation.dart';

part 'api_exception.g.dart';
@JsonSerializable()
class ApiException {
    @JsonKey(name: "eventTime")
    DateTime? eventTime;
    @JsonKey(name: "error")
    String? error;
    @JsonKey(name: "errorDescription")
    String? errorDescription;
    @JsonKey(name: "errorCode")
    String? errorCode;

    ApiException({
         this.eventTime,
         this.error,
         this.errorDescription,
         this.errorCode,
    });

    factory ApiException.fromJson(Map<String, dynamic> json) => _$ApiExceptionFromJson(json);

    Map<String, dynamic> toJson() => _$ApiExceptionToJson(this);
}
