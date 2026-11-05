import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
abstract class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      cardColor: AppColors.surface,
      textTheme: TextTheme(
        bodyMedium: AppTextStyles.body,
        titleLarge: AppTextStyles.title,
        displayLarge: AppTextStyles.balance,
      ),
      // Настройка цветов для стандартных компонентов Material 3
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),

      // Стили кнопок (например, закругленные кнопки "Отправить" / "Получить")
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Скругление как в Tonkeeper
          ),
        ),
      ),
    );
  }
}
