import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

/// Miktar seçici widget'ı — +/- butonları ile miktar artırma/azaltma.
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool compact;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = compact ? 28.0 : 36.0;
    final fontSize = compact ? 14.0 : 16.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Azalt butonu
          _buildButton(
            icon: Icons.remove,
            onTap: onDecrement,
            size: buttonSize,
          ),

          // Miktar gösterimi
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? AppSizes.paddingSM : AppSizes.paddingMD,
            ),
            child: Text(
              quantity.toString(),
              style: AppTextStyles.titleMedium.copyWith(
                fontSize: fontSize,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Artır butonu
          _buildButton(
            icon: Icons.add,
            onTap: onIncrement,
            size: buttonSize,
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onTap,
    required double size,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.cardBackground,
          shape: BoxShape.circle,
          border: isPrimary
              ? null
              : Border.all(color: AppColors.divider, width: 1),
        ),
        child: Icon(
          icon,
          size: size * 0.5,
          color: isPrimary ? AppColors.textOnPrimary : AppColors.textSecondary,
        ),
      ),
    );
  }
}
