import 'package:flutter/material.dart';
import '../../cart/models/cart_item.dart';
import '../models/order.dart';

/// Sipariş state yönetimi.
/// Sipariş oluşturma, geçmiş siparişler ve sipariş takip işlemlerini yönetir.
class OrderProvider extends ChangeNotifier {
  // ── State ────────────────────────────────────────────────────
  /// Sipariş geçmişi
  final List<Order> _orders = [];
  List<Order> get orders => List.unmodifiable(_orders);

  /// Aktif sipariş (takip edilen)
  Order? _activeOrder;
  Order? get activeOrder => _activeOrder;

  /// Sipariş geçmişi boş mu?
  bool get isEmpty => _orders.isEmpty;

  /// Toplam sipariş sayısı
  int get orderCount => _orders.length;

  // ── Aksiyon Metodları ────────────────────────────────────────
  /// Yeni sipariş oluştur
  Order createOrder({
    required List<CartItem> items,
    required double totalPrice,
    required String deliveryAddress,
  }) {
    final order = Order(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      items: items.map((e) => e.copyWith()).toList(),
      totalPrice: totalPrice,
      status: OrderStatus.received,
      orderDate: DateTime.now(),
      deliveryAddress: deliveryAddress,
    );

    _orders.insert(0, order); // En yeni en üstte
    _activeOrder = order;
    notifyListeners();
    return order;
  }

  /// Sipariş durumunu güncelle (demo amaçlı)
  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(status: newStatus);
      if (_activeOrder?.id == orderId) {
        _activeOrder = _orders[index];
      }
      notifyListeners();
    }
  }

  /// ID ile sipariş bul
  Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((o) => o.id == orderId);
    } catch (_) {
      return null;
    }
  }

  /// Aktif siparişi temizle
  void clearActiveOrder() {
    _activeOrder = null;
    notifyListeners();
  }

  /// Demo: Sipariş durumunu bir adım ileri al
  void advanceOrderStatus(String orderId) {
    final order = getOrderById(orderId);
    if (order == null) return;

    OrderStatus? nextStatus;
    switch (order.status) {
      case OrderStatus.received:
        nextStatus = OrderStatus.preparing;
        break;
      case OrderStatus.preparing:
        nextStatus = OrderStatus.onTheWay;
        break;
      case OrderStatus.onTheWay:
        nextStatus = OrderStatus.delivered;
        break;
      case OrderStatus.delivered:
        nextStatus = null; // Zaten son durum
        break;
    }

    if (nextStatus != null) {
      updateOrderStatus(orderId, nextStatus);
    }
  }
}
