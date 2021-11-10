class HotShop {
  final int id;
  final String name;
  final String address;
  final String thumbUrl;

//<editor-fold desc="Data Methods">

  const HotShop({
    required this.id,
    required this.name,
    required this.address,
    required this.thumbUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HotShop &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          address == other.address &&
          thumbUrl == other.thumbUrl);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ address.hashCode ^ thumbUrl.hashCode;

  @override
  String toString() {
    return 'HotShop{' +
        ' id: $id,' +
        ' name: $name,' +
        ' address: $address,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

  HotShop copyWith({
    int? id,
    String? name,
    String? address,
    String? thumbUrl,
  }) {
    return HotShop(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      thumbUrl: thumbUrl ?? this.thumbUrl,
    );
  }

//</editor-fold>
}
