import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';

class ProductCategoryHomeResponse extends Equatable {
  final int? id;
  final String? name;
  final String? thumbUrl;

  ProductCategoryHomeResponse({
    this.id,
    this.name,
    this.thumbUrl,
  });

  factory ProductCategoryHomeResponse.fromJson(Map<String, dynamic> json) {
    return ProductCategoryHomeResponse(
      id: json.parseInt('id'),
      name: json.parseString('name'),
      thumbUrl: json.parseString('thumbUrl'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['thumbUrl'] = thumbUrl;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        thumbUrl,
      ];
}
