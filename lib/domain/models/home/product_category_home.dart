import 'package:equatable/equatable.dart';

class ProductCategoryHomeEntity extends Equatable {
  final int id;
  final String name;
  final String thumbUrl;

  const ProductCategoryHomeEntity({
    required this.id,
    required this.name,
    required this.thumbUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        thumbUrl,
      ];
}
