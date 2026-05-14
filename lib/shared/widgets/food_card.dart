import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';
import '../../features/home/models/food_item.dart';
import '../../features/favorites/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

/// Yemek kartı widget'ı — Ana sayfada grid görünümünde kullanılır.
/// Her kart: emoji, isim, fiyat, rating ve favori butonu içerir.
class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Emoji Görseli + Favori Butonu ────────────────────
            _buildImageSection(context),

            // ── Bilgi Bölümü ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Yemek adı
                  Text(
                    food.name,
                    style: AppTextStyles.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.paddingXS),

                  // Süre ve kalori
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: AppSizes.iconSM,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSizes.paddingXS),
                      Text(
                        '${food.prepTimeMinutes} dk',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(width: AppSizes.paddingSM),
                      Text('•', style: AppTextStyles.bodySmall),
                      const SizedBox(width: AppSizes.paddingSM),
                      Text(
                        '${food.calories} kcal',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingSM),

                  // Fiyat ve rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₺${food.price.toStringAsFixed(0)}',
                        style: AppTextStyles.priceMedium,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: AppSizes.iconSM,
                            color: AppColors.starYellow,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            food.rating.toString(),
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
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

  /// Emoji görsel bölümü + favori butonu
  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        // Emoji arka planı
        Container(
          width: double.infinity,
          height: 100,
          decoration: const BoxDecoration(
            gradient: AppColors.softPinkGradient,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes.radiusLG),
            ),
          ),
          child: Center(
            child: Hero(
              tag: 'food_${food.id}',
              child: Text(
                food.emoji,
                style: const TextStyle(fontSize: AppSizes.emojiLarge),
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
                  padding: const EdgeInsets.all(AppSizes.paddingXS),
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
      ],
    );
  }
}
