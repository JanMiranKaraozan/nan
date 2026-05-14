import 'package:flutter/material.dart';

/// Uygulama genelinde kullanılan renk sabitleri.
/// Tüm renkler bu dosyadan yönetilir — magic color kullanımı önlenir.
class AppColors {
  AppColors._(); // Instance oluşturmayı engelle

  // ── Ana Renkler ──────────────────────────────────────────────
  /// Ana pembe renk — butonlar, vurgular, aktif öğeler
  static const Color primary = Color(0xFFE91E63);

  /// Açık pembe — arka plan vurguları, chip'ler
  static const Color primaryLight = Color(0xFFF8BBD0);

  /// Çok açık pembe — kartlar, yüzeyler
  static const Color primarySurface = Color(0xFFFCE4EC);

  /// Koyu pembe — basılı durum, hover
  static const Color primaryDark = Color(0xFFC2185B);

  // ── Arka Plan Renkleri ───────────────────────────────────────
  /// Ana arka plan — beyaz
  static const Color background = Color(0xFFFFFBFE);

  /// Scaffold arka planı — çok hafif pembe tonu
  static const Color scaffoldBackground = Color(0xFFFFF5F7);

  /// Kart arka planı
  static const Color cardBackground = Color(0xFFFFFFFF);

  /// Alt navigasyon arka planı
  static const Color bottomNavBackground = Color(0xFFFFFFFF);

  // ── Metin Renkleri ───────────────────────────────────────────
  /// Ana metin rengi — koyu gri
  static const Color textPrimary = Color(0xFF1A1A2E);

  /// İkincil metin — orta gri
  static const Color textSecondary = Color(0xFF757575);

  /// Açık metin — placeholderlar
  static const Color textHint = Color(0xFFBDBDBD);

  /// Beyaz metin — pembe buton üzeri
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ── Durum Renkleri ───────────────────────────────────────────
  /// Başarılı — yeşil
  static const Color success = Color(0xFF4CAF50);

  /// Uyarı — amber
  static const Color warning = Color(0xFFFFC107);

  /// Hata — kırmızı
  static const Color error = Color(0xFFE53935);

  /// Yıldız/rating rengi
  static const Color starYellow = Color(0xFFFFB300);

  // ── Diğer ────────────────────────────────────────────────────
  /// Ayırıcı çizgi rengi
  static const Color divider = Color(0xFFEEEEEE);

  /// Gölge rengi
  static const Color shadow = Color(0x1A000000);

  /// İnaktif ikon rengi
  static const Color iconInactive = Color(0xFFBDBDBD);

  /// Arama çubuğu arka planı
  static const Color searchBarBackground = Color(0xFFF5F5F5);

  // ── Gradient'ler ─────────────────────────────────────────────
  /// Ana gradient — butonlar ve vurgular için
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFE91E63), Color(0xFFFF5252)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Yumuşak pembe gradient — kartlar için
  static const LinearGradient softPinkGradient = LinearGradient(
    colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
