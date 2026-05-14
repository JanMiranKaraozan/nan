import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../features/cart/providers/cart_provider.dart';

/// Özel alt navigasyon barı widget'ı.
/// 5 tab: Ana Sayfa, Favoriler, Sepet, Siparişler, Profil
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomNavBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: AppSizes.bottomNavHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_rounded, Icons.home_outlined, AppStrings.navHome),
              _buildNavItem(1, Icons.favorite_rounded, Icons.favorite_border_rounded, AppStrings.navFavorites),
              _buildCenterCartItem(context),
              _buildNavItem(3, Icons.receipt_long_rounded, Icons.receipt_long_outlined, AppStrings.navOrders),
              _buildNavItem(4, Icons.person_rounded, Icons.person_outline_rounded, AppStrings.navProfile),
            ],
          ),
        ),
      ),
    );
  }

  /// Normal navigasyon öğesi
  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primarySurface : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
              child: Icon(
                isActive ? activeIcon : inactiveIcon,
                color: isActive ? AppColors.primary : AppColors.iconInactive,
                size: AppSizes.iconLG,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: isActive ? AppTextStyles.navLabelActive : AppTextStyles.navLabel,
            ),
          ],
        ),
      ),
    );
  }

  /// Sepet navigasyon öğesi (badge ile)
  Widget _buildCenterCartItem(BuildContext context) {
    final isActive = currentIndex == 2;

    return GestureDetector(
      onTap: () => onTap(2),
      behavior: HitTestBehavior.opaque,
      child: Consumer<CartProvider>(
        builder: (_, cart, __) {
          return SizedBox(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primarySurface : Colors.transparent,
                        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                      ),
                      child: Icon(
                        isActive ? Icons.shopping_bag_rounded : Icons.shopping_bag_outlined,
                        color: isActive ? AppColors.primary : AppColors.iconInactive,
                        size: AppSizes.iconLG,
                      ),
                    ),
                    if (cart.totalItemCount > 0)
                      Positioned(
                        top: -2,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            cart.totalItemCount > 9 ? '9+' : cart.totalItemCount.toString(),
                            style: AppTextStyles.badge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  AppStrings.navCart,
                  style: isActive ? AppTextStyles.navLabelActive : AppTextStyles.navLabel,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
