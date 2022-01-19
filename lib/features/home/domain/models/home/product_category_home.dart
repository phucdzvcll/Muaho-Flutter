import 'package:equatable/equatable.dart';

class ProductCategoryHomeEntity extends Equatable {
  final int id;
  final String name;
  final String thumbUrl;
  final String deepLink;

  const ProductCategoryHomeEntity({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.deepLink,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        thumbUrl,
        deepLink,
      ];
}
