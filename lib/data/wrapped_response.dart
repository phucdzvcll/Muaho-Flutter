import 'package:json_annotation/json_annotation.dart';

part 'wrapped_response.g.dart';

class WrappedResponse {
  Header? header;
}

@JsonSerializable()
class Header {
  final bool? isSuccessful;
  final int? resultCode;
  final String? resultMessage;

  Header(
      {required this.isSuccessful,
      required this.resultCode,
      required this.resultMessage});

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}
