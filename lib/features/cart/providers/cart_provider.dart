import 'package:flutter/material.dart';
import '../../home/models/food_item.dart';
import '../models/cart_item.dart';
import '../../../core/constants/app_strings.dart';

/// Sepet state yönetimi (global provider).
/// Sepete ekleme, çıkarma, miktar güncelleme ve toplam hesaplama.
class CartProvider extends ChangeNotifier {
  // ── State ────────────────────────────────────────────────────
  /// Sepetteki öğeler
  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  // ── Hesaplamalar ─────────────────────────────────────────────
  /// Sepetteki toplam ürün sayısı
  int get totalItemCount =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  /// Ara toplam (teslimat ücreti hariç)
  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Teslimat ücreti (150₺ üzeri ücretsiz)
  double get deliveryFee {
    if (subtotal >= AppStrings.freeDeliveryThreshold || _items.isEmpty) {
      return 0.0;
    }
    return AppStrings.deliveryFeeAmount;
  }

  /// Genel toplam
  double get total => subtotal + deliveryFee;

  /// Sepet boş mu?
  bool get isEmpty => _items.isEmpty;

  /// Ücretsiz teslimat için kalan tutar
  double get remainingForFreeDelivery {
    final remaining = AppStrings.freeDeliveryThreshold - subtotal;
    return remaining > 0 ? remaining : 0;
  }

  // ── Aksiyon Metodları ────────────────────────────────────────
  /// Sepete yemek ekle
  void addToCart(FoodItem food, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((item) => item.food.id == food.id);

    if (existingIndex != -1) {
      // Zaten sepette varsa miktarı artır
      _items[existingIndex].quantity += quantity;
    } else {
      // Yeni öğe ekle
      _items.add(CartItem(food: food, quantity: quantity));
    }
    notifyListeners();
  }

  /// Sepetten yemek çıkar
  void removeFromCart(String foodId) {
    _items.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  /// Miktar artır
  void incrementQuantity(String foodId) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  /// Miktar azalt (1'den az olursa kaldır)
  void decrementQuantity(String foodId) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Öğe notu güncelle
  void updateNote(String foodId, String note) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    if (index != -1) {
      _items[index].note = note.isEmpty ? null : note;
      notifyListeners();
    }
  }

  /// Belirli yemek sepette mi?
  bool isInCart(String foodId) {
    return _items.any((item) => item.food.id == foodId);
  }

  /// Sepetteki yemek miktarı
  int getQuantity(String foodId) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    return index != -1 ? _items[index].quantity : 0;
  }

  /// Sepeti tamamen temizle
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
