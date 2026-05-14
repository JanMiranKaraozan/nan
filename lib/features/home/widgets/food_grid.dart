import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/food_card.dart';
import '../models/food_item.dart';

/// Yemek ızgara (grid) görünümü widget'ı.
class FoodGrid extends StatelessWidget {
  final List<FoodItem> foods;
  final ValueChanged<String> onFoodTap;

  const FoodGrid({
    super.key,
    required this.foods,
    required this.onFoodTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Başlık
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
          child: Text(AppStrings.allFoods, style: AppTextStyles.displaySmall),
        ),
        const SizedBox(height: AppSizes.paddingMD),

        // Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSizes.paddingMD,
              mainAxisSpacing: AppSizes.paddingMD,
              childAspectRatio: 0.72,
            ),
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final food = foods[index];
              return FoodCard(
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
