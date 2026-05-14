import 'package:flutter/material.dart';
import '../../home/models/food_item.dart';

/// Favoriler state yönetimi.
/// Yemekleri favorilere ekleme/çıkarma işlemlerini yönetir.
class FavoritesProvider extends ChangeNotifier {
  // ── State ────────────────────────────────────────────────────
  /// Favori yemek ID'leri
  final Set<String> _favoriteIds = {};

  /// Favori yemek listesi (FoodItem referansları)
  final List<FoodItem> _favorites = [];
  List<FoodItem> get favorites => List.unmodifiable(_favorites);

  /// Favori sayısı
  int get count => _favorites.length;

  /// Favoriler boş mu?
  bool get isEmpty => _favorites.isEmpty;

  // ── Aksiyon Metodları ────────────────────────────────────────
  /// Yemek favori mi?
  bool isFavorite(String foodId) => _favoriteIds.contains(foodId);

  /// Favori durumunu değiştir (toggle)
  void toggleFavorite(FoodItem food) {
    if (_favoriteIds.contains(food.id)) {
      // Favoriden çıkar
      _favoriteIds.remove(food.id);
      _favorites.removeWhere((f) => f.id == food.id);
    } else {
      // Favoriye ekle
      _favoriteIds.add(food.id);
      _favorites.add(food);
    }
    notifyListeners();
  }

  /// Favoriden çıkar (ID ile)
  void removeFavorite(String foodId) {
    _favoriteIds.remove(foodId);
    _favorites.removeWhere((f) => f.id == foodId);
    notifyListeners();
  }

  /// Tüm favorileri temizle
  void clearFavorites() {
    _favoriteIds.clear();
    _favorites.clear();
    notifyListeners();
  }
}
