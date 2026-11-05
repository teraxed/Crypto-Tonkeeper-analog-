import 'package:Crypto/features/config/theme/app_colors.dart';
import 'package:Crypto/features/config/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  // Одна строка настроек
  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppColors.textSecondary),
      ),
    );
  }

  // Пока пункт не готов, показываем "Скоро"
  void _soon(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.soon),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text(
              AppStrings.settingsTitle,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _tile(
            context,
            icon: Icons.palette_rounded,
            title: AppStrings.settingsWallet,
            onTap: () => context.push('/wallet-customization'),
          ),
          _tile(
            context,
            icon: Icons.key_rounded,
            title: AppStrings.settingsSeed,
            onTap: () => _soon(context),
          ),
          _tile(
            context,
            icon: Icons.lock_rounded,
            title: AppStrings.settingsPin,
            onTap: () => _soon(context),
          ),
        ],
      ),
    );
  }
}