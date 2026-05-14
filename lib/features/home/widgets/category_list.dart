import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/category_chip.dart';
import '../models/category.dart';

/// Yatay kategori listesi widget'ı.
class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Başlık
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
          child: Text(
            AppStrings.categories,
            style: AppTextStyles.displaySmall,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMD),

        // Yatay scroll listesi
        SizedBox(
          height: AppSizes.categoryChipHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
            itemCount: categories.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: AppSizes.paddingSM),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryChip(
                label: category.name,
                emoji: category.emoji,
                isSelected: selectedCategoryId == category.id,
                onTap: () => onCategorySelected(category.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
