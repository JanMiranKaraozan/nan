import '../../cart/models/cart_item.dart';

/// Sipariş durumu enum'u
enum OrderStatus {
  received,   // Sipariş alındı
  preparing,  // Hazırlanıyor
  onTheWay,   // Yolda
  delivered,  // Teslim edildi
}

/// Sipariş modeli.
class Order {
  /// Benzersiz sipariş numarası
  final String id;

  /// Sipariş öğeleri
  final List<CartItem> items;

  /// Toplam fiyat
  final double totalPrice;

  /// Sipariş durumu
  final OrderStatus status;

  /// Sipariş tarihi
  final DateTime orderDate;

  /// Teslimat adresi
  final String deliveryAddress;

  const Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.orderDate,
    required this.deliveryAddress,
  });

  /// Siparişteki toplam ürün sayısı
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  /// Durum metni (Türkçe)
  String get statusText {
    switch (status) {
      case OrderStatus.received:
        return 'Sipariş Alındı';
      case OrderStatus.preparing:
        return 'Hazırlanıyor';
      case OrderStatus.onTheWay:
        return 'Yolda';
      case OrderStatus.delivered:
        return 'Teslim Edildi';
    }
  }

  /// Durum emoji'si
  String get statusEmoji {
    switch (status) {
      case OrderStatus.received:
        return '📋';
      case OrderStatus.preparing:
        return '👨‍🍳';
      case OrderStatus.onTheWay:
        return '🛵';
      case OrderStatus.delivered:
        return '✅';
    }
  }

  /// Kopya oluştur
  Order copyWith({
    String? id,
    List<CartItem>? items,
    double? totalPrice,
    OrderStatus? status,
    DateTime? orderDate,
    String? deliveryAddress,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    );
  }
}
