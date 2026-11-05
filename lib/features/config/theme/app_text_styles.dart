import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  // Для отображения большого баланса (например, "142.50 TON")
  static const TextStyle balance = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Для заголовков меню и карточек
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Для обычного текста и подписей (адреса, даты)
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}
