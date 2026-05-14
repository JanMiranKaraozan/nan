import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../../../shared/widgets/quantity_selector.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';
import '../../orders/providers/order_provider.dart';
import '../../profile/providers/profile_provider.dart';

/// Sepet ekranı.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(title: Text('${AppStrings.cart} (${cart.totalItemCount})')),
          body: cart.isEmpty
              ? const EmptyStateWidget(emoji: '🛒', title: AppStrings.cartEmpty, description: AppStrings.cartEmptyDesc)
              : _buildCartContent(context, cart),
          bottomSheet: cart.isEmpty ? null : _buildBottomSection(context, cart),
        );
      },
    );
  }

  Widget _buildCartContent(BuildContext context, CartProvider cart) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 220),
      itemCount: cart.items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _CartItemCard(item: cart.items[index]),
    );
  }

  Widget _buildBottomSection(BuildContext context, CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingXXL),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (cart.remainingForFreeDelivery > 0) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  const Icon(Icons.local_shipping_outlined, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text('₺${cart.remainingForFreeDelivery.toStringAsFixed(0)} daha ekleyin, teslimat ücretsiz!', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500))),
                ]),
              ),
              const SizedBox(height: 12),
            ],
            _priceRow(AppStrings.subtotal, '₺${cart.subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            _priceRow(AppStrings.deliveryFee, cart.deliveryFee == 0 ? AppStrings.freeDelivery : '₺${cart.deliveryFee.toStringAsFixed(2)}'),
            const Divider(height: 24),
            _priceRow(AppStrings.total, '₺${cart.total.toStringAsFixed(2)}', isBold: true),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity, height: 52,
              child: ElevatedButton(onPressed: () => _placeOrder(context, cart), child: Text(AppStrings.placeOrder, style: AppTextStyles.buttonPrimary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: isBold ? AppTextStyles.titleMedium : AppTextStyles.bodyMedium),
      Text(value, style: isBold ? AppTextStyles.priceLarge.copyWith(fontSize: 20) : AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
    ]);
  }

  void _placeOrder(BuildContext context, CartProvider cart) {
    final profile = context.read<ProfileProvider>().profile;
    context.read<OrderProvider>().createOrder(items: cart.items, totalPrice: cart.total, deliveryAddress: profile.address);
    cart.clearCart();
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('🎉', style: TextStyle(fontSize: 64)),
        const SizedBox(height: 16),
        Text(AppStrings.orderSuccess, style: AppTextStyles.titleLarge),
        const SizedBox(height: 8),
        Text(AppStrings.orderSuccessDesc, style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text(AppStrings.ok))),
      ]),
    ));
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    return Dismissible(
      key: Key(item.food.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => cart.removeFromCart(item.food.id),
      background: Container(
        alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 32),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))]),
        child: Row(children: [
          Container(width: 64, height: 64, decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(12)), child: Center(child: Text(item.food.emoji, style: const TextStyle(fontSize: 40)))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.food.name, style: AppTextStyles.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text('₺${item.totalPrice.toStringAsFixed(0)}', style: AppTextStyles.priceMedium),
          ])),
          QuantitySelector(compact: true, quantity: item.quantity, onIncrement: () => cart.incrementQuantity(item.food.id), onDecrement: () => cart.decrementQuantity(item.food.id)),
        ]),
      ),
    );
  }
}
