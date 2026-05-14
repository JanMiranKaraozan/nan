/// Yemek öğesi modeli.
/// Mock data ve UI tarafından kullanılır.
class FoodItem {
  /// Benzersiz kimlik
  final String id;

  /// Yemek adı
  final String name;

  /// Yemek açıklaması
  final String description;

  /// Fiyat (TL)
  final double price;

  /// Emoji görseli (resim yerine)
  final String emoji;

  /// Kategori kimliği
  final String categoryId;

  /// Kullanıcı puanı (1-5)
  final double rating;

  /// Hazırlık süresi (dakika)
  final int prepTimeMinutes;

  /// Malzeme listesi
  final List<String> ingredients;

  /// Popüler mi?
  final bool isPopular;

  /// Kalori miktarı
  final int calories;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.emoji,
    required this.categoryId,
    required this.rating,
    required this.prepTimeMinutes,
    required this.ingredients,
    this.isPopular = false,
    required this.calories,
  });

  /// Kopya oluştur (immutability için)
  FoodItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? emoji,
    String? categoryId,
    double? rating,
    int? prepTimeMinutes,
    List<String>? ingredients,
    bool? isPopular,
    int? calories,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      emoji: emoji ?? this.emoji,
      categoryId: categoryId ?? this.categoryId,
      rating: rating ?? this.rating,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      ingredients: ingredients ?? this.ingredients,
      isPopular: isPopular ?? this.isPopular,
      calories: calories ?? this.calories,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FoodItem && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
