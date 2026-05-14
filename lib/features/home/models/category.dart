/// Yemek kategorisi modeli.
class Category {
  /// Benzersiz kimlik
  final String id;

  /// Kategori adı
  final String name;

  /// Kategori emojisi
  final String emoji;

  const Category({
    required this.id,
    required this.name,
    required this.emoji,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Category && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
