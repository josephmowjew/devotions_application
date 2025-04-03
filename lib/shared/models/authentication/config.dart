import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
    @JsonKey(name: "profileConfigId")
    int? profileConfigId;
    @JsonKey(name: "twoFactorEnabled")
    bool? twoFactorEnabled;
    @JsonKey(name: "emailAddress")
    String? emailAddress;
    @JsonKey(name: "communicationMethod")
    String? communicationMethod;
    @JsonKey(name: "twoFactorConfig")
    dynamic twoFactorConfig;

    Config({
        this.profileConfigId,
        this.twoFactorEnabled,
        this.emailAddress,
        this.communicationMethod,
        this.twoFactorConfig,
    });

    factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

    Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
