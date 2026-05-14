import '../models/food_item.dart';
import '../models/category.dart';

/// Sahte (mock) yemek verisi servisi.
/// Backend olmadığı için tüm veriler burada yönetilir.
class FoodRepository {
  /// Tüm kategoriler
  static const List<Category> categories = [
    Category(id: 'all', name: 'Tümü', emoji: '🍽️'),
    Category(id: 'kebap', name: 'Kebap', emoji: '🍖'),
    Category(id: 'pizza', name: 'Pizza', emoji: '🍕'),
    Category(id: 'burger', name: 'Burger', emoji: '🍔'),
    Category(id: 'salata', name: 'Salata', emoji: '🥗'),
    Category(id: 'makarna', name: 'Makarna', emoji: '🍝'),
    Category(id: 'tatli', name: 'Tatlı', emoji: '🍰'),
    Category(id: 'icecek', name: 'İçecek', emoji: '🥤'),
  ];

  /// Tüm yemekler — Türk mutfağından zengin çeşitlilik
  static const List<FoodItem> allFoods = [
    // ── Kebaplar ────────────────────────────────────────────────
    FoodItem(
      id: 'kebap_1',
      name: 'Adana Kebap',
      description:
          'Özel baharatlarla hazırlanmış, közde pişirilmiş el yapımı Adana kebabı. Yanında lavaş, közlenmiş domates ve biber ile servis edilir.',
      price: 185.0,
      emoji: '🍖',
      categoryId: 'kebap',
      rating: 4.8,
      prepTimeMinutes: 25,
      ingredients: ['Kıyma', 'Biber', 'Baharatlar', 'Lavaş', 'Soğan'],
      isPopular: true,
      calories: 520,
    ),
    FoodItem(
      id: 'kebap_2',
      name: 'İskender Kebap',
      description:
          'İnce dilimlenmiş döner eti, tereyağlı domates sosu ve yoğurt yatağında. Bursa\'nın efsane lezzeti.',
      price: 210.0,
      emoji: '🥩',
      categoryId: 'kebap',
      rating: 4.9,
      prepTimeMinutes: 20,
      ingredients: ['Döner Eti', 'Yoğurt', 'Tereyağı', 'Domates Sosu', 'Pide'],
      isPopular: true,
      calories: 650,
    ),
    FoodItem(
      id: 'kebap_3',
      name: 'Tavuk Şiş',
      description:
          'Marine edilmiş tavuk göğsü, renkli biberler ve soğan ile şişte közlenmiş. Pilav ve salata eşliğinde.',
      price: 145.0,
      emoji: '🍗',
      categoryId: 'kebap',
      rating: 4.5,
      prepTimeMinutes: 20,
      ingredients: ['Tavuk Göğsü', 'Biber', 'Soğan', 'Pilav', 'Marine Sos'],
      isPopular: false,
      calories: 380,
    ),

    // ── Pizzalar ────────────────────────────────────────────────
    FoodItem(
      id: 'pizza_1',
      name: 'Karışık Pizza',
      description:
          'Sucuk, sosis, mantar, mısır, yeşil biber ve bol mozzarella peyniri ile hazırlanmış özel pizza.',
      price: 159.0,
      emoji: '🍕',
      categoryId: 'pizza',
      rating: 4.6,
      prepTimeMinutes: 30,
      ingredients: ['Sucuk', 'Sosis', 'Mantar', 'Mısır', 'Mozzarella', 'Biber'],
      isPopular: true,
      calories: 780,
    ),
    FoodItem(
      id: 'pizza_2',
      name: 'Margarita Pizza',
      description:
          'Taze domates sosu, mozzarella peyniri ve fesleğen yaprakları. İtalyan klasiği.',
      price: 129.0,
      emoji: '🫓',
      categoryId: 'pizza',
      rating: 4.4,
      prepTimeMinutes: 25,
      ingredients: ['Domates Sosu', 'Mozzarella', 'Fesleğen', 'Zeytinyağı'],
      isPopular: false,
      calories: 620,
    ),
    FoodItem(
      id: 'pizza_3',
      name: 'Sucuklu Pide',
      description:
          'Fırında pişirilmiş çıtır hamur üzerinde bol sucuk, kaşar peyniri ve yumurta.',
      price: 139.0,
      emoji: '🥖',
      categoryId: 'pizza',
      rating: 4.7,
      prepTimeMinutes: 20,
      ingredients: ['Sucuk', 'Kaşar', 'Yumurta', 'Pide Hamuru'],
      isPopular: true,
      calories: 580,
    ),

    // ── Burgerler ───────────────────────────────────────────────
    FoodItem(
      id: 'burger_1',
      name: 'Klasik Burger',
      description:
          '180gr özel harmanlanmış dana köfte, cheddar peyniri, marul, domates, turşu ve özel sos.',
      price: 135.0,
      emoji: '🍔',
      categoryId: 'burger',
      rating: 4.5,
      prepTimeMinutes: 15,
      ingredients: ['Dana Köfte', 'Cheddar', 'Marul', 'Domates', 'Turşu', 'Özel Sos'],
      isPopular: true,
      calories: 720,
    ),
    FoodItem(
      id: 'burger_2',
      name: 'Tavuk Burger',
      description:
          'Çıtır panelenmiş tavuk fileto, ranch sos, marul ve domates ile brioche ekmeğinde.',
      price: 119.0,
      emoji: '🐔',
      categoryId: 'burger',
      rating: 4.3,
      prepTimeMinutes: 15,
      ingredients: ['Tavuk Fileto', 'Ranch Sos', 'Marul', 'Domates', 'Brioche'],
      isPopular: false,
      calories: 580,
    ),

    // ── Salatalar ───────────────────────────────────────────────
    FoodItem(
      id: 'salata_1',
      name: 'Sezar Salata',
      description:
          'Izgara tavuk göğsü, romaine marul, parmesan peyniri, kruton ve sezar sos.',
      price: 95.0,
      emoji: '🥗',
      categoryId: 'salata',
      rating: 4.4,
      prepTimeMinutes: 10,
      ingredients: ['Tavuk', 'Marul', 'Parmesan', 'Kruton', 'Sezar Sos'],
      isPopular: false,
      calories: 320,
    ),
    FoodItem(
      id: 'salata_2',
      name: 'Çoban Salata',
      description:
          'Taze domates, salatalık, biber, soğan ve maydanoz. Zeytinyağı ve limon sosu ile.',
      price: 55.0,
      emoji: '🥒',
      categoryId: 'salata',
      rating: 4.2,
      prepTimeMinutes: 5,
      ingredients: ['Domates', 'Salatalık', 'Biber', 'Soğan', 'Maydanoz'],
      isPopular: false,
      calories: 120,
    ),

    // ── Makarnalar ──────────────────────────────────────────────
    FoodItem(
      id: 'makarna_1',
      name: 'Fettuccine Alfredo',
      description:
          'Kremali parmesan sosunda taze fettuccine makarna. İsteğe göre tavuk veya mantar eklenebilir.',
      price: 115.0,
      emoji: '🍝',
      categoryId: 'makarna',
      rating: 4.6,
      prepTimeMinutes: 20,
      ingredients: ['Fettuccine', 'Krema', 'Parmesan', 'Tereyağı', 'Sarımsak'],
      isPopular: true,
      calories: 580,
    ),
    FoodItem(
      id: 'makarna_2',
      name: 'Bolonez Makarna',
      description:
          'Kıymalı domates sosunda penne makarna. Üzerinde rendelenmiş parmesan peyniri.',
      price: 105.0,
      emoji: '🍜',
      categoryId: 'makarna',
      rating: 4.5,
      prepTimeMinutes: 25,
      ingredients: ['Penne', 'Kıyma', 'Domates Sosu', 'Parmesan', 'Soğan'],
      isPopular: false,
      calories: 520,
    ),

    // ── Tatlılar ────────────────────────────────────────────────
    FoodItem(
      id: 'tatli_1',
      name: 'Künefe',
      description:
          'Antep fıstıklı, peynirli sıcak künefe. Şerbet ile servis edilir. Yanında dondurma.',
      price: 95.0,
      emoji: '🍰',
      categoryId: 'tatli',
      rating: 4.9,
      prepTimeMinutes: 15,
      ingredients: ['Kadayıf', 'Peynir', 'Şerbet', 'Antep Fıstığı', 'Dondurma'],
      isPopular: true,
      calories: 450,
    ),
    FoodItem(
      id: 'tatli_2',
      name: 'Sütlaç',
      description:
          'Geleneksel fırında sütlaç. Üzeri kızarmış, soğuk servis edilir.',
      price: 65.0,
      emoji: '🍮',
      categoryId: 'tatli',
      rating: 4.6,
      prepTimeMinutes: 10,
      ingredients: ['Süt', 'Pirinç', 'Şeker', 'Nişasta', 'Vanilya'],
      isPopular: false,
      calories: 280,
    ),
    FoodItem(
      id: 'tatli_3',
      name: 'Baklava',
      description:
          'Gaziantep usulü, ince yufkadan el açması, bol Antep fıstıklı baklava.',
      price: 120.0,
      emoji: '🥮',
      categoryId: 'tatli',
      rating: 4.8,
      prepTimeMinutes: 5,
      ingredients: ['Yufka', 'Antep Fıstığı', 'Tereyağı', 'Şerbet'],
      isPopular: true,
      calories: 380,
    ),

    // ── İçecekler ───────────────────────────────────────────────
    FoodItem(
      id: 'icecek_1',
      name: 'Ayran',
      description: 'Geleneksel ev yapımı ayran. Soğuk servis edilir.',
      price: 25.0,
      emoji: '🥛',
      categoryId: 'icecek',
      rating: 4.3,
      prepTimeMinutes: 2,
      ingredients: ['Yoğurt', 'Su', 'Tuz'],
      isPopular: false,
      calories: 80,
    ),
    FoodItem(
      id: 'icecek_2',
      name: 'Taze Limonata',
      description:
          'Taze sıkılmış limon, nane yaprakları ve buz ile hazırlanmış ev yapımı limonata.',
      price: 35.0,
      emoji: '🍋',
      categoryId: 'icecek',
      rating: 4.5,
      prepTimeMinutes: 5,
      ingredients: ['Limon', 'Şeker', 'Nane', 'Buz'],
      isPopular: false,
      calories: 120,
    ),
    FoodItem(
      id: 'icecek_3',
      name: 'Türk Kahvesi',
      description:
          'Geleneksel usulde cezvede pişirilmiş Türk kahvesi. Yanında lokum ile.',
      price: 40.0,
      emoji: '☕',
      categoryId: 'icecek',
      rating: 4.7,
      prepTimeMinutes: 8,
      ingredients: ['Kahve', 'Su', 'Şeker (isteğe bağlı)', 'Lokum'],
      isPopular: true,
      calories: 15,
    ),
  ];

  /// Popüler yemekleri getir
  static List<FoodItem> getPopularFoods() {
    return allFoods.where((food) => food.isPopular).toList();
  }

  /// Kategoriye göre yemekleri filtrele
  static List<FoodItem> getFoodsByCategory(String categoryId) {
    if (categoryId == 'all') return allFoods;
    return allFoods.where((food) => food.categoryId == categoryId).toList();
  }

  /// ID ile yemek bul
  static FoodItem? getFoodById(String id) {
    try {
      return allFoods.firstWhere((food) => food.id == id);
    } catch (_) {
      return null;
    }
  }

  /// İsme göre yemek ara
  static List<FoodItem> searchFoods(String query) {
    final lowerQuery = query.toLowerCase();
    return allFoods.where((food) {
      return food.name.toLowerCase().contains(lowerQuery) ||
          food.description.toLowerCase().contains(lowerQuery) ||
          food.ingredients.any((i) => i.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
