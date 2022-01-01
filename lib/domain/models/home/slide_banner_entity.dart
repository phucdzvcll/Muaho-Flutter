import 'package:equatable/equatable.dart';

class SlideBannerEntity extends Equatable {
  final int id;
  final String subject;
  final String description;
  final String thumbUrl;

  final String deepLinkUrl;

  const SlideBannerEntity({
    required this.id,
    required this.subject,
    required this.description,
    required this.thumbUrl,
    required this.deepLinkUrl,
  });

  @override
  List<Object?> get props => [
        id,
        subject,
        description,
        thumbUrl,
        deepLinkUrl,
      ];
}
