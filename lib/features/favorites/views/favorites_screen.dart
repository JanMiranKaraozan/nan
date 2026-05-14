import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../providers/favorites_provider.dart';

/// Favoriler ekranı.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favProvider, _) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(title: const Text(AppStrings.favorites)),
          body: favProvider.isEmpty
              ? const EmptyStateWidget(
                  emoji: '❤️',
                  title: AppStrings.favoritesEmpty,
                  description: AppStrings.favoritesEmptyDesc,
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(AppSizes.paddingLG),
                  itemCount: favProvider.favorites.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final food = favProvider.favorites[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
                      ),
                      child: Row(
                        children: [
                          // Emoji
                          Container(
                            width: 64, height: 64,
                            decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(12)),
                            child: Center(child: Text(food.emoji, style: const TextStyle(fontSize: 40))),
                          ),
                          const SizedBox(width: 12),
                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(food.name, style: AppTextStyles.titleSmall),
                                const SizedBox(height: 4),
                                Row(children: [
                                  const Icon(Icons.star_rounded, size: 14, color: AppColors.starYellow),
                                  const SizedBox(width: 4),
                                  Text(food.rating.toString(), style: AppTextStyles.bodySmall),
                                  const SizedBox(width: 8),
                                  Text('•', style: AppTextStyles.bodySmall),
                                  const SizedBox(width: 8),
                                  Text('${food.prepTimeMinutes} dk', style: AppTextStyles.bodySmall),
                                ]),
                                const SizedBox(height: 4),
                                Text('₺${food.price.toStringAsFixed(0)}', style: AppTextStyles.priceMedium),
                              ],
                            ),
                          ),
                          // Actions
                          Column(children: [
                            GestureDetector(
                              onTap: () => favProvider.toggleFavorite(food),
                              child: const Icon(Icons.favorite, color: AppColors.primary, size: 24),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/food-detail', arguments: food.id),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(8)),
                                child: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.primary),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
