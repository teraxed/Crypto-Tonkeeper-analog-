import 'package:flutter/material.dart';

abstract class AppColors {
  // Фоновые цвета
  static const Color background = Color(0xFF111A24);
  static const Color surface = Color(0xFF1C2733);
  static const Color bottomSheet = Color(0xFF16212E);

  // Брендовые цвета (Цвет TON)
  static const Color primary = Color(0xFF0098EA);
  static const Color primaryLight = Color(0xFF33B6FF);

  // Текст
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF708396);

  // Статусы
  static const Color success = Color(0xFF22C55E); // Зеленый (+TON)
  static const Color error = Color(0xFFEF4444);   // Красный

  // NEW: Цвета для кошелька (кастомизация)
  static const List<Color> wallet = [
    Color(0xFF0098EA), // Синий (TON)
    Color(0xFF7C5CFC), // Фиолетовый
    Color(0xFFE056FD), // Розовый
    Color(0xFFFF5C8A), // Малиновый
    Color(0xFFEF4444), // Красный
    Color(0xFFFF8A3D), // Оранжевый
    Color(0xFFFFC53D), // Жёлтый
    Color(0xFF22C55E), // Зелёный
    Color(0xFF14B8A6), // Бирюзовый
    Color(0xFF64748B), // Серый
  ];

  // Экран ПИН-кода (Pin Code Screen)

}