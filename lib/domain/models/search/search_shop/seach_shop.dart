class SearchShop {
  final int id;
  final String name;
  final String address;
  final String thumbUrl;
  final double star;

//<editor-fold desc="Data Methods">

  const SearchShop({
    required this.id,
    required this.name,
    required this.address,
    required this.thumbUrl,
    required this.star,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchShop &&
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
    return 'SearchShop{' +
        ' id: $id,' +
        ' name: $name,' +
        ' address: $address,' +
        ' thumbUrl: $thumbUrl,' +
        ' start: $star,' +
        '}';
  }

  SearchShop copyWith({
    int? id,
    String? name,
    String? address,
    String? thumbUrl,
    double? start,
  }) {
    return SearchShop(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      star: start ?? this.star,
    );
  }

//</editor-fold>
}
