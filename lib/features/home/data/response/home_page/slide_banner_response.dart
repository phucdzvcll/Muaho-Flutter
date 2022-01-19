import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class SlideBannerResponse extends Equatable {
  final int? id;
  final String? subject;
  final String? description;
  final String? thumbUrl;
  final String? deeplink;

  SlideBannerResponse({
    this.id,
    this.subject,
    this.description,
    this.thumbUrl,
    this.deeplink,
  });

  factory SlideBannerResponse.fromJson(Map<String, dynamic> json) {
    return SlideBannerResponse(
      id: json.parseInt('id'),
      subject: json.parseString('subject'),
      description: json.parseString('description'),
      thumbUrl: json.parseString('thumbUrl'),
      deeplink: json.parseString('deeplink'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['subject'] = subject;
    data['description'] = description;
    data['thumbUrl'] = thumbUrl;
    data['deeplink'] = deeplink;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        subject,
        description,
        thumbUrl,
        deeplink,
      ];
}
