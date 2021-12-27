import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop_response.g.dart';

@JsonSerializable()
class ShopResponse extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  @JsonKey(name: "thumb_url")
  final String? thumbUrl;
  final double? star;

  factory ShopResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopResponseToJson(this);

  const ShopResponse({
    this.id,
    this.name,
    this.address,
    this.thumbUrl,
    this.star,
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
