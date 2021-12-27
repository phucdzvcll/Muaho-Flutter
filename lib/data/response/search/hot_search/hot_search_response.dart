import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hot_search_response.g.dart';

@JsonSerializable()
class HotSearchResponse extends Equatable {
  final List<HotKeywordResponse>? keywords;
  final List<HotShopResponse>? shops;

  factory HotSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$HotSearchResponseFromJson(json);

  HotSearchResponse({this.keywords, this.shops});

  Map<String, dynamic> toJson() => _$HotSearchResponseToJson(this);

  @override
  List<Object?> get props => [keywords, shops];
}

@JsonSerializable()
class HotKeywordResponse extends Equatable {
  final String? name;

  factory HotKeywordResponse.fromJson(Map<String, dynamic> json) =>
      _$HotKeywordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotKeywordResponseToJson(this);

  const HotKeywordResponse({
    this.name,
  });

  @override
  List<Object?> get props => [name];
}

@JsonSerializable()
class HotShopResponse extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final String? thumbUrl;

  factory HotShopResponse.fromJson(Map<String, dynamic> json) =>
      _$HotShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotShopResponseToJson(this);

  const HotShopResponse({
    this.id,
    this.name,
    this.address,
    this.thumbUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        thumbUrl,
      ];
}
