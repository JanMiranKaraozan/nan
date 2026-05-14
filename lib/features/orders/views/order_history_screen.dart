import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';

/// Sipariş geçmişi ekranı.
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(title: const Text(AppStrings.orders)),
          body: orderProvider.isEmpty
              ? const EmptyStateWidget(
                  emoji: '📦',
                  title: AppStrings.ordersEmpty,
                  description: AppStrings.ordersEmptyDesc,
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(AppSizes.paddingLG),
                  itemCount: orderProvider.orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = orderProvider.orders[index];
                    return _OrderCard(order: order);
                  },
                ),
        );
      },
    );
  }
}

/// Sipariş kartı widget'ı.
class _OrderCard extends StatelessWidget {
  final Order order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/order-tracking', arguments: order.id),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst satır: Sipariş no ve durum
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.id.substring(0, 15), style: AppTextStyles.titleSmall),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(order.statusEmoji, style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 4),
                      Text(order.statusText, style: AppTextStyles.bodySmall.copyWith(color: _getStatusColor(order.status), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Ürünler özeti
            Row(
              children: [
                ...order.items.take(3).map((item) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(item.food.emoji, style: const TextStyle(fontSize: 24)),
                )),
                if (order.items.length > 3)
                  Text('+${order.items.length - 3}', style: AppTextStyles.bodySmall),
              ],
            ),
            const SizedBox(height: 8),

            // Alt satır: tarih ve fiyat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDate(order.orderDate), style: AppTextStyles.bodySmall),
                Text('₺${order.totalPrice.toStringAsFixed(2)}', style: AppTextStyles.priceMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.received: return AppColors.warning;
      case OrderStatus.preparing: return AppColors.primary;
      case OrderStatus.onTheWay: return Colors.blue;
      case OrderStatus.delivered: return AppColors.success;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
