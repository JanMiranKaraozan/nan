import 'package:flutter/material.dart';
import '../models/user_profile.dart';

/// Profil state yönetimi.
/// Kullanıcı bilgilerini yönetir.
class ProfileProvider extends ChangeNotifier {
  // ── State ────────────────────────────────────────────────────
  /// Kullanıcı profili (mock data)
  UserProfile _profile = UserProfile.mock();
  UserProfile get profile => _profile;

  // ── Aksiyon Metodları ────────────────────────────────────────
  /// Profil bilgilerini güncelle
  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? avatarEmoji,
  }) {
    _profile = _profile.copyWith(
      name: name,
      email: email,
      phone: phone,
      address: address,
      avatarEmoji: avatarEmoji,
    );
    notifyListeners();
  }

  /// Adresi güncelle
  void updateAddress(String address) {
    _profile = _profile.copyWith(address: address);
    notifyListeners();
  }
}
