import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class ShopResponse extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final String? thumbUrl;
  final double? star;

  ShopResponse({
    this.id,
    this.name,
    this.address,
    this.thumbUrl,
    this.star,
  });

  factory ShopResponse.fromJson(Map<String, dynamic> json) {
    return ShopResponse(
      id: json.parseInt('id'),
      name: json.parseString('name'),
      address: json.parseString('address'),
      thumbUrl: json.parseString('thumb_url'),
      star: json.parseDouble('star'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['thumb_url'] = thumbUrl;
    data['star'] = star;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        thumbUrl,
        star,
      ];
}
