import 'package:json_annotation/json_annotation.dart';

part 'slide_banner_response.g.dart';

@JsonSerializable()
class SlideBannerResponse {
  final int? id;
  final String? subject;
  final String? description;
  final String? thumbUrl;
  final String? deeplink;

//<editor-fold desc="Data Methods">
  @override
  String toString() {
    return 'Data{id: $id, subject: $subject, description: $description, thumbUrl: $thumbUrl}';
  }

  const SlideBannerResponse({
    required this.id,
    required this.subject,
    required this.description,
    required this.thumbUrl,
    required this.deeplink,
  });

  factory SlideBannerResponse.fromJson(Map<String, dynamic> json) =>
      _$SlideBannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SlideBannerResponseToJson(this);
}
//</editor-fold>
