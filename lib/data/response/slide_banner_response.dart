import 'package:json_annotation/json_annotation.dart';
import 'package:muaho/data/wrapped_response.dart';

part 'slide_banner_response.g.dart';

@JsonSerializable()
class SlideBannerResponse extends WrappedResponse {
  final List<Data>? data;

//<editor-fold desc="Data Methods">

  SlideBannerResponse({
    required this.data,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SlideBannerResponse &&
          runtimeType == other.runtimeType &&
          data == other.data);

  factory SlideBannerResponse.fromJson(Map<String, dynamic> json) =>
      _$SlideBannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SlideBannerResponseToJson(this);

//</editor-fold>
}

@JsonSerializable()
class Data {
  final int? id;
  final String? subject;
  final String? description;
  final String? thumbUrl;

//<editor-fold desc="Data Methods">

  const Data({
    required this.id,
    required this.subject,
    required this.description,
    required this.thumbUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Data &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          subject == other.subject &&
          description == other.description &&
          thumbUrl == other.thumbUrl);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

//</editor-fold>
}
