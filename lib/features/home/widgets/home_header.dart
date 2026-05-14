import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/cart_badge.dart';

/// Ana sayfa üst başlık widget'ı.
/// Logo, selamlama, arama ve sepet ikonu içerir.
class HomeHeader extends StatelessWidget {
  final VoidCallback onCartTap;
  final VoidCallback onSearchTap;

  const HomeHeader({
    super.key,
    required this.onCartTap,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingLG,
        vertical: AppSizes.paddingSM,
      ),
      child: Row(
        children: [
          // Logo
          SvgPicture.asset(
            'assets/logo.svg',
            width: 40,
            height: 40,
          ),
          const SizedBox(width: AppSizes.paddingMD),

          // Selamlama metni
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppStrings.homeGreeting} 👋',
                  style: AppTextStyles.bodySmall,
                ),
                Text(
                  AppStrings.homeTitle,
                  style: AppTextStyles.titleMedium,
                ),
              ],
            ),
          ),

          // Arama butonu
          GestureDetector(
            onTap: onSearchTap,
            child: Container(
              padding: const EdgeInsets.all(AppSizes.paddingSM),
              decoration: BoxDecoration(
                color: AppColors.searchBarBackground,
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              ),
              child: const Icon(
                Icons.search_rounded,
                color: AppColors.textSecondary,
                size: AppSizes.iconLG,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.paddingSM),

          // Sepet ikonu
          CartBadge(onTap: onCartTap),
        ],
      ),
    );
  }
}
