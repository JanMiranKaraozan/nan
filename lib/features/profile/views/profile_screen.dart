import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../providers/profile_provider.dart';

/// Profil ekranı.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        final profile = profileProvider.profile;
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(title: const Text(AppStrings.profile)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            child: Column(
              children: [
                // Profil kartı
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingXXL),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                    boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 6))],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                        child: Center(child: Text(profile.avatarEmoji, style: const TextStyle(fontSize: 40))),
                      ),
                      const SizedBox(height: 12),
                      Text(profile.name, style: AppTextStyles.titleLarge.copyWith(color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(profile.email, style: AppTextStyles.bodySmall.copyWith(color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Menü öğeleri
                _menuItem(Icons.receipt_long_outlined, AppStrings.myOrders, () {}),
                _menuItem(Icons.location_on_outlined, AppStrings.myAddresses, () {}),
                _menuItem(Icons.payment_outlined, AppStrings.paymentMethods, () {}),
                _menuItem(Icons.settings_outlined, AppStrings.settings, () {}),
                _menuItem(Icons.help_outline_rounded, AppStrings.helpAndSupport, () {}),
                _menuItem(Icons.info_outline_rounded, AppStrings.about, () {}),
                const SizedBox(height: 16),
                _menuItem(Icons.logout_rounded, AppStrings.logout, () {}, isDestructive: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _menuItem(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 4, offset: const Offset(0, 1))],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: isDestructive ? AppColors.error : AppColors.primary, size: 22),
        title: Text(title, style: AppTextStyles.bodyLarge.copyWith(color: isDestructive ? AppColors.error : AppColors.textPrimary)),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: isDestructive ? AppColors.error : AppColors.textHint),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMD)),
      ),
    );
  }
}
