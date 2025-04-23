import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class Description {
  final String? text;
  final String? url;
  final String? urlTitle;

  const Description({
    this.text,
    this.url,
    this.urlTitle,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        text: json['text'] as String?,
        url: json['url'] as String?,
        urlTitle: json['urlTitle'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (text != null) 'text': text,
        if (url != null) 'url': url,
        if (urlTitle != null) 'urlTitle': urlTitle,
      };
}