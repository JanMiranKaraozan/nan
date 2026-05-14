import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/quantity_selector.dart';
import '../../home/models/food_item.dart';
import '../../home/repositories/food_repository.dart';
import '../../cart/providers/cart_provider.dart';
import '../../favorites/providers/favorites_provider.dart';

/// Yemek detay ekranı.
/// Hero animasyonlu görsel, açıklama, malzemeler, fiyat ve sepete ekleme.
class FoodDetailScreen extends StatefulWidget {
  final String foodId;

  const FoodDetailScreen({super.key, required this.foodId});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final food = FoodRepository.getFoodById(widget.foodId);
    if (food == null) {
      return const Scaffold(
        body: Center(child: Text('Yemek bulunamadı')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          // ── Hero görsel alanı ─────────────────────────────────
          SliverToBoxAdapter(child: _buildHeroSection(context, food)),

          // ── Bilgi bölümü ──────────────────────────────────────
          SliverToBoxAdapter(child: _buildInfoSection(food)),

          // ── İstatistikler ─────────────────────────────────────
          SliverToBoxAdapter(child: _buildStatsRow(food)),

          // ── Açıklama ──────────────────────────────────────────
          SliverToBoxAdapter(child: _buildDescription(food)),

          // ── Malzemeler ────────────────────────────────────────
          SliverToBoxAdapter(child: _buildIngredients(food)),

          // Alt boşluk
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),

      // ── Alt kısım: Miktar + Sepete Ekle ────────────────────
      bottomSheet: _buildBottomBar(food),
    );
  }

  /// Hero animasyonlu üst görsel bölümü
  Widget _buildHeroSection(BuildContext context, FoodItem food) {
    return Stack(
      children: [
        // Arka plan gradient
        Container(
          width: double.infinity,
          height: 300,
          decoration: const BoxDecoration(
            gradient: AppColors.softPinkGradient,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(AppSizes.radiusXXL),
            ),
          ),
          child: Center(
            child: Hero(
              tag: 'food_${food.id}',
              child: Text(
                food.emoji,
                style: const TextStyle(fontSize: AppSizes.emojiHero),
              ),
            ),
          ),
        ),

        // Geri butonu
        Positioned(
          top: MediaQuery.of(context).padding.top + AppSizes.paddingSM,
          left: AppSizes.paddingLG,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(AppSizes.paddingSM),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: AppSizes.iconMD,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),

        // Favori butonu
        Positioned(
          top: MediaQuery.of(context).padding.top + AppSizes.paddingSM,
          right: AppSizes.paddingLG,
          child: Consumer<FavoritesProvider>(
            builder: (_, favProvider, __) {
              final isFav = favProvider.isFavorite(food.id);
              return GestureDetector(
                onTap: () {
                  favProvider.toggleFavorite(food);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav
                            ? AppStrings.removedFromFavorites
                            : AppStrings.addedToFavorites,
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.paddingSM),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                  ),
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    size: AppSizes.iconMD,
                    color: isFav ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Yemek adı, rating, fiyat
  Widget _buildInfoSection(FoodItem food) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingXXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // İsim ve fiyat
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(food.name, style: AppTextStyles.displayMedium),
              ),
              Text(
                '₺${food.price.toStringAsFixed(0)}',
                style: AppTextStyles.priceLarge,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingSM),

          // Rating
          Row(
            children: [
              const Icon(Icons.star_rounded, size: 20, color: AppColors.starYellow),
              const SizedBox(width: 4),
              Text(
                food.rating.toString(),
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: AppSizes.paddingSM),
              Text(
                '(120+ değerlendirme)',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Hazırlık süresi, kalori, rating istatistikleri
  Widget _buildStatsRow(FoodItem food) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingXXL),
      child: Row(
        children: [
          _buildStatItem(Icons.access_time_rounded, '${food.prepTimeMinutes} ${AppStrings.minutes}', AppStrings.prepTime),
          const SizedBox(width: AppSizes.paddingMD),
          _buildStatItem(Icons.local_fire_department_rounded, '${food.calories}', AppStrings.calories),
          const SizedBox(width: AppSizes.paddingMD),
          _buildStatItem(Icons.star_rounded, food.rating.toString(), AppStrings.rating),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingMD),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: AppSizes.iconLG),
            const SizedBox(height: AppSizes.paddingXS),
            Text(value, style: AppTextStyles.titleSmall),
            Text(label, style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }

  /// Açıklama
  Widget _buildDescription(FoodItem food) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingXXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.description, style: AppTextStyles.titleLarge),
          const SizedBox(height: AppSizes.paddingSM),
          Text(food.description, style: AppTextStyles.bodyLarge),
        ],
      ),
    );
  }

  /// Malzeme listesi (chip'ler)
  Widget _buildIngredients(FoodItem food) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingXXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.ingredients, style: AppTextStyles.titleLarge),
          const SizedBox(height: AppSizes.paddingMD),
          Wrap(
            spacing: AppSizes.paddingSM,
            runSpacing: AppSizes.paddingSM,
            children: food.ingredients.map((ingredient) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMD,
                  vertical: AppSizes.paddingSM,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  border: Border.all(color: AppColors.primaryLight, width: 1),
                ),
                child: Text(
                  ingredient,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Alt bar: miktar seçici + sepete ekle
  Widget _buildBottomBar(FoodItem food) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingXXL),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Miktar seçici
            QuantitySelector(
              quantity: _quantity,
              onIncrement: () => setState(() => _quantity++),
              onDecrement: () {
                if (_quantity > 1) setState(() => _quantity--);
              },
            ),
            const SizedBox(width: AppSizes.paddingLG),

            // Sepete ekle butonu
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.read<CartProvider>().addToCart(food, quantity: _quantity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${food.name} sepete eklendi!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  height: AppSizes.buttonHeight,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        color: AppColors.textOnPrimary,
                        size: AppSizes.iconLG,
                      ),
                      const SizedBox(width: AppSizes.paddingSM),
                      Text(
                        '${AppStrings.addToCart} • ₺${(food.price * _quantity).toStringAsFixed(0)}',
                        style: AppTextStyles.buttonPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
