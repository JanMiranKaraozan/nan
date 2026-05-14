import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

/// Arama çubuğu widget'ı.
class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onClose;
  final TextEditingController? controller;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
    required this.onClose,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingLG,
        vertical: AppSizes.paddingSM,
      ),
      child: Container(
        height: AppSizes.searchBarHeight,
        decoration: BoxDecoration(
          color: AppColors.searchBarBackground,
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        child: Row(
          children: [
            const SizedBox(width: AppSizes.paddingMD),
            const Icon(
              Icons.search_rounded,
              color: AppColors.textHint,
              size: AppSizes.iconMD,
            ),
            const SizedBox(width: AppSizes.paddingSM),

            // Arama text field
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                autofocus: true,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: AppStrings.searchHint,
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textHint,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  filled: false,
                ),
              ),
            ),

            // Kapat butonu
            GestureDetector(
              onTap: onClose,
              child: Container(
                padding: const EdgeInsets.all(AppSizes.paddingSM),
                child: const Icon(
                  Icons.close_rounded,
                  color: AppColors.textSecondary,
                  size: AppSizes.iconMD,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.paddingXS),
          ],
        ),
      ),
    );
  }
}
