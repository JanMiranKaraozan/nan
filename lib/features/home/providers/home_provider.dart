import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/category.dart';
import '../repositories/food_repository.dart';

/// Ana sayfa state yönetimi.
/// Yemek listesi, kategori filtreleme ve arama işlemlerini yönetir.
class HomeProvider extends ChangeNotifier {
  // ── State Değişkenleri ────────────────────────────────────────
  /// Seçili kategori ID'si
  String _selectedCategoryId = 'all';
  String get selectedCategoryId => _selectedCategoryId;

  /// Arama sorgusu
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  /// Arama modu aktif mi?
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  // ── Getter'lar ───────────────────────────────────────────────
  /// Tüm kategoriler
  List<Category> get categories => FoodRepository.categories;

  /// Popüler yemekler
  List<FoodItem> get popularFoods => FoodRepository.getPopularFoods();

  /// Filtrelenmiş yemek listesi (kategori + arama)
  List<FoodItem> get filteredFoods {
    List<FoodItem> foods;

    // Önce kategoriye göre filtrele
    if (_selectedCategoryId == 'all') {
      foods = FoodRepository.allFoods;
    } else {
      foods = FoodRepository.getFoodsByCategory(_selectedCategoryId);
    }

    // Arama sorgusu varsa, ayrıca filtrele
    if (_searchQuery.isNotEmpty) {
      final lowerQuery = _searchQuery.toLowerCase();
      foods = foods.where((food) {
        return food.name.toLowerCase().contains(lowerQuery) ||
            food.description.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    return foods;
  }

  // ── Aksiyon Metodları ────────────────────────────────────────
  /// Kategori seç
  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  /// Arama sorgusunu güncelle
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Arama modunu aç/kapat
  void toggleSearch() {
    _isSearching = !_isSearching;
    if (!_isSearching) {
      _searchQuery = '';
    }
    notifyListeners();
  }

  /// Aramayı kapat ve sıfırla
  void closeSearch() {
    _isSearching = false;
    _searchQuery = '';
    notifyListeners();
  }
}
