import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class ShopResponse extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final String? thumb_url;
  final double? star;

  ShopResponse({
    this.id,
    this.name,
    this.address,
    this.thumb_url,
    this.star,
  });

  factory ShopResponse.fromJson(Map<String, dynamic> json) {
    return ShopResponse(
      id: json.parseInt('id'),
      name: json.parseString('name'),
      address: json.parseString('address'),
      thumb_url: json.parseString('thumb_url'),
      star: json.parseDouble('star'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['thumb_url'] = thumb_url;
    data['star'] = star;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        thumb_url,
        star,
      ];
}
