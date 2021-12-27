import 'package:equatable/equatable.dart';

class SearchShop extends Equatable {
  final int id;
  final String name;
  final String address;
  final String thumbUrl;
  final double star;

  const SearchShop({
    required this.id,
    required this.name,
    required this.address,
    required this.thumbUrl,
    required this.star,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        thumbUrl,
        star,
      ];
}
