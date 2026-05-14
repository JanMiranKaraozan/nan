import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';

/// Sipariş takip ekranı — stepper ile sipariş durumu gösterimi.
class OrderTrackingScreen extends StatelessWidget {
  final String orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        final order = orderProvider.getOrderById(orderId);
        if (order == null) {
          return Scaffold(appBar: AppBar(), body: const Center(child: Text('Sipariş bulunamadı')));
        }
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(title: const Text(AppStrings.orderTracking)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            child: Column(
              children: [
                // Sipariş durumu stepper
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingXXL),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                    boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      Text(order.statusEmoji, style: const TextStyle(fontSize: 48)),
                      const SizedBox(height: 12),
                      Text(order.statusText, style: AppTextStyles.titleLarge),
                      const SizedBox(height: 24),
                      _buildStep(AppStrings.orderReceived, '📋', order.status.index >= 0),
                      _buildStepLine(order.status.index >= 1),
                      _buildStep(AppStrings.preparing, '👨‍🍳', order.status.index >= 1),
                      _buildStepLine(order.status.index >= 2),
                      _buildStep(AppStrings.onTheWay, '🛵', order.status.index >= 2),
                      _buildStepLine(order.status.index >= 3),
                      _buildStep(AppStrings.delivered, '✅', order.status.index >= 3),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Sipariş detayları
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingLG),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                    boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sipariş Detayları', style: AppTextStyles.titleMedium),
                      const SizedBox(height: 12),
                      ...order.items.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Text(item.food.emoji, style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Expanded(child: Text('${item.food.name} x${item.quantity}', style: AppTextStyles.bodyMedium)),
                            Text('₺${item.totalPrice.toStringAsFixed(0)}', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.total, style: AppTextStyles.titleMedium),
                          Text('₺${order.totalPrice.toStringAsFixed(2)}', style: AppTextStyles.priceMedium),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Demo: durumu ileri al butonu
                if (order.status != OrderStatus.delivered)
                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.buttonHeight,
                    child: OutlinedButton(
                      onPressed: () => orderProvider.advanceOrderStatus(orderId),
                      child: const Text('Demo: Durumu İleri Al'),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep(String title, String emoji, bool isActive) {
    return Row(
      children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.searchBarBackground,
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(emoji, style: TextStyle(fontSize: isActive ? 18 : 14))),
        ),
        const SizedBox(width: 12),
        Text(title, style: AppTextStyles.bodyLarge.copyWith(
          color: isActive ? AppColors.textPrimary : AppColors.textHint,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        )),
      ],
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Container(
      margin: const EdgeInsets.only(left: 19),
      width: 2, height: 30,
      color: isActive ? AppColors.primary : AppColors.divider,
    );
  }
}
