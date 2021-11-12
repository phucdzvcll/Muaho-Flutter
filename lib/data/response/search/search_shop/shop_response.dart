import 'package:json_annotation/json_annotation.dart';

part 'shop_response.g.dart';

@JsonSerializable()
class ShopResponse {
  final int? id;
  final String? name;
  final String? address;
  final String? thumbUrl;
  final double? star;

  factory ShopResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopResponseToJson(this);

//<editor-fold desc="Data Methods">

  const ShopResponse({
    this.id,
    this.name,
    this.address,
    this.thumbUrl,
    this.star,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          address == other.address &&
          thumbUrl == other.thumbUrl &&
          star == other.star);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      thumbUrl.hashCode ^
      star.hashCode;

  @override
  String toString() {
    return 'ShopResponse{' +
        ' id: $id,' +
        ' name: $name,' +
        ' address: $address,' +
        ' thumbUrl: $thumbUrl,' +
        ' star: $star,' +
        '}';
  }
//</editor-fold>
}
