import "package:Crypto/features/core/error/error_screen.dart";
import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";

import "../../../config/theme/app_colors.dart";
import "../../../config/theme/app_text_styles.dart";
import "../../../config/theme/app_strings.dart"; // Импортируем словарь

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.authTitle, style: AppTextStyles.balance),
              const SizedBox(height: 12),
              Text(
                AppStrings.authSubtitle, 
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: () {
context.go('/pin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(AppStrings.createWallet, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ErrorScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(AppStrings.importWallet, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
