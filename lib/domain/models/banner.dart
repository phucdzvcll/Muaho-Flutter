class Banner {
  final int id;
  final String subject;
  final String description;
  final String thumbUrl;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">
  const Banner({
    required this.id,
    required this.subject,
    required this.description,
    required this.thumbUrl,
  });

  Banner copyWith({
    int? id,
    String? subject,
    String? description,
    String? thumbUrl,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (subject == null || identical(subject, this.subject)) &&
        (description == null || identical(description, this.description)) &&
        (thumbUrl == null || identical(thumbUrl, this.thumbUrl))) {
      return this;
    }

    return new Banner(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      thumbUrl: thumbUrl ?? this.thumbUrl,
    );
  }

  @override
  String toString() {
    return 'Banner{id: $id, subject: $subject, description: $description, thumbUrl: $thumbUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Banner &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          subject == other.subject &&
          description == other.description &&
          thumbUrl == other.thumbUrl);

  @override
  int get hashCode =>
      id.hashCode ^ subject.hashCode ^ description.hashCode ^ thumbUrl.hashCode;
  //</editor-fold>
}
