/// Kullanıcı profil modeli.
class UserProfile {
  /// Kullanıcı adı
  final String name;

  /// E-posta adresi
  final String email;

  /// Telefon numarası
  final String phone;

  /// Adres
  final String address;

  /// Avatar emoji
  final String avatarEmoji;

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.avatarEmoji = '👤',
  });

  /// Varsayılan mock kullanıcı
  factory UserProfile.mock() {
    return const UserProfile(
      name: 'Ayşe Yılmaz',
      email: 'ayse@nanyiyorum.com',
      phone: '+90 555 123 45 67',
      address: 'Bağdat Cad. No:42, Kadıköy/İstanbul',
      avatarEmoji: '👩',
    );
  }

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? avatarEmoji,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatarEmoji: avatarEmoji ?? this.avatarEmoji,
    );
  }
}
