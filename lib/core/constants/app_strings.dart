/// Uygulama genelinde kullanılan metin sabitleri (Türkçe).
/// Tüm kullanıcıya gösterilen metinler burada tutulur.
class AppStrings {
  AppStrings._();

  // ── Uygulama ─────────────────────────────────────────────────
  static const String appName = 'Nan Yiyorum';
  static const String appSlogan = 'Lezzetin Adresi';

  // ── Genel ────────────────────────────────────────────────────
  static const String search = 'Ara';
  static const String searchHint = 'Yemek veya restoran ara...';
  static const String cancel = 'İptal';
  static const String save = 'Kaydet';
  static const String ok = 'Tamam';
  static const String yes = 'Evet';
  static const String no = 'Hayır';
  static const String loading = 'Yükleniyor...';
  static const String error = 'Bir hata oluştu';
  static const String retry = 'Tekrar Dene';

  // ── Ana Sayfa ────────────────────────────────────────────────
  static const String homeTitle = 'Ne yemek istersin?';
  static const String homeGreeting = 'Merhaba';
  static const String categories = 'Kategoriler';
  static const String popularFoods = 'Popüler Yemekler';
  static const String allFoods = 'Tüm Yemekler';
  static const String seeAll = 'Tümünü Gör';
  static const String allCategories = 'Tümü';

  // ── Yemek Detay ──────────────────────────────────────────────
  static const String description = 'Açıklama';
  static const String ingredients = 'Malzemeler';
  static const String addToCart = 'Sepete Ekle';
  static const String prepTime = 'Hazırlık';
  static const String calories = 'Kalori';
  static const String rating = 'Puan';
  static const String minutes = 'dk';
  static const String kcal = 'kcal';

  // ── Sepet ────────────────────────────────────────────────────
  static const String cart = 'Sepetim';
  static const String cartEmpty = 'Sepetiniz boş';
  static const String cartEmptyDesc = 'Hadi lezzetli yemekler ekleyelim!';
  static const String subtotal = 'Ara Toplam';
  static const String deliveryFee = 'Teslimat Ücreti';
  static const String total = 'Toplam';
  static const String placeOrder = 'Sipariş Ver';
  static const String removeFromCart = 'Sepetten Kaldır';
  static const String addNote = 'Not ekle...';
  static const String freeDelivery = 'Ücretsiz';
  static const String currencySymbol = '₺';

  // ── Favoriler ────────────────────────────────────────────────
  static const String favorites = 'Favorilerim';
  static const String favoritesEmpty = 'Henüz favoriniz yok';
  static const String favoritesEmptyDesc =
      'Beğendiğiniz yemekleri kalp ikonuna tıklayarak ekleyin.';
  static const String addedToFavorites = 'Favorilere eklendi';
  static const String removedFromFavorites = 'Favorilerden çıkarıldı';

  // ── Profil ───────────────────────────────────────────────────
  static const String profile = 'Profilim';
  static const String myOrders = 'Siparişlerim';
  static const String myAddresses = 'Adreslerim';
  static const String paymentMethods = 'Ödeme Yöntemlerim';
  static const String settings = 'Ayarlar';
  static const String helpAndSupport = 'Yardım & Destek';
  static const String about = 'Hakkında';
  static const String logout = 'Çıkış Yap';
  static const String editProfile = 'Profili Düzenle';

  // ── Siparişler ───────────────────────────────────────────────
  static const String orders = 'Siparişlerim';
  static const String ordersEmpty = 'Henüz siparişiniz yok';
  static const String ordersEmptyDesc = 'İlk siparişinizi verin!';
  static const String orderTracking = 'Sipariş Takip';
  static const String orderReceived = 'Sipariş Alındı';
  static const String preparing = 'Hazırlanıyor';
  static const String onTheWay = 'Yolda';
  static const String delivered = 'Teslim Edildi';
  static const String orderDate = 'Sipariş Tarihi';
  static const String orderNumber = 'Sipariş No';
  static const String orderAgain = 'Tekrar Sipariş Ver';
  static const String orderSuccess = 'Siparişiniz alındı!';
  static const String orderSuccessDesc =
      'Siparişiniz hazırlanmaya başlandı. Afiyet olsun! 🎉';

  // ── Alt Navigasyon ───────────────────────────────────────────
  static const String navHome = 'Ana Sayfa';
  static const String navFavorites = 'Favoriler';
  static const String navCart = 'Sepet';
  static const String navOrders = 'Siparişler';
  static const String navProfile = 'Profil';

  // ── Teslimat ─────────────────────────────────────────────────
  static const double deliveryFeeAmount = 14.99;
  static const double freeDeliveryThreshold = 150.0;
}
