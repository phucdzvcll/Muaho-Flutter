import 'package:equatable/equatable.dart';

class HotShop extends Equatable {
  final int id;
  final String name;
  final String address;
  final String thumbUrl;

  const HotShop({
    required this.id,
    required this.name,
    required this.address,
    required this.thumbUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        thumbUrl,
      ];
}
