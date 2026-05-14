import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../features/favorites/providers/favorites_provider.dart';
import '../models/food_item.dart';

/// Popüler yemekler bölümü — yatay scroll kartlar.
class PopularSection extends StatelessWidget {
  final List<FoodItem> popularFoods;
  final ValueChanged<String> onFoodTap;

  const PopularSection({
    super.key,
    required this.popularFoods,
    required this.onFoodTap,
  });

  @override
  Widget build(BuildContext context) {
    if (popularFoods.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Başlık satırı
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.popularFoods, style: AppTextStyles.displaySmall),
              TextButton(
                onPressed: () {},
                child: Text(AppStrings.seeAll, style: AppTextStyles.buttonSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.paddingSM),

        // Yatay kart listesi
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
            itemCount: popularFoods.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: AppSizes.paddingMD),
            itemBuilder: (context, index) {
              final food = popularFoods[index];
              return _PopularFoodCard(
                food: food,
                onTap: () => onFoodTap(food.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Popüler yemek kartı — büyük yatay kart.
class _PopularFoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;

  const _PopularFoodCard({
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSizes.popularCardWidth,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji arka planı + favori
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                    gradient: AppColors.softPinkGradient,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppSizes.radiusLG),
                    ),
                  ),
                  child: Center(
                    child: Hero(
                      tag: 'food_${food.id}',
                      child: Text(
                        food.emoji,
                        style: const TextStyle(fontSize: AppSizes.emojiXLarge),
                      ),
                    ),
                  ),
                ),

                // Favori butonu
                Positioned(
                  top: AppSizes.paddingSM,
                  right: AppSizes.paddingSM,
                  child: Consumer<FavoritesProvider>(
                    builder: (_, favProvider, __) {
                      final isFav = favProvider.isFavorite(food.id);
                      return GestureDetector(
                        onTap: () => favProvider.toggleFavorite(food),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            size: AppSizes.iconMD,
                            color: isFav ? AppColors.primary : AppColors.textSecondary,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Rating badge
                Positioned(
                  top: AppSizes.paddingSM,
                  left: AppSizes.paddingSM,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingSM,
                      vertical: AppSizes.paddingXS,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 14, color: AppColors.starYellow),
                        const SizedBox(width: 2),
                        Text(
                          food.rating.toString(),
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Bilgi bölümü
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: AppTextStyles.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.paddingXS),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text('${food.prepTimeMinutes} dk', style: AppTextStyles.bodySmall),
                        ],
                      ),
                      Text(
                        '₺${food.price.toStringAsFixed(0)}',
                        style: AppTextStyles.priceMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
