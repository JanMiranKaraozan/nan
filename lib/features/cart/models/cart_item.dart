import '../../home/models/food_item.dart';

/// Sepet öğesi modeli.
/// Bir yemek ve miktar bilgisini tutar.
class CartItem {
  /// İlişkili yemek
  final FoodItem food;

  /// Miktar
  int quantity;

  /// Müşteri notu (opsiyonel)
  String? note;

  CartItem({
    required this.food,
    this.quantity = 1,
    this.note,
  });

  /// Bu öğenin toplam fiyatı
  double get totalPrice => food.price * quantity;

  /// Kopya oluştur
  CartItem copyWith({
    FoodItem? food,
    int? quantity,
    String? note,
  }) {
    return CartItem(
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CartItem && food.id == other.food.id;

  @override
  int get hashCode => food.id.hashCode;
}
