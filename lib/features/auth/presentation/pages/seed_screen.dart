import 'package:Crypto/features/auth/presentation/widgets/generator.dart';
import 'package:Crypto/features/core/error/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_strings.dart';
import '../../../config/theme/app_text_styles.dart';
// Импортируйте генератор фраз, который мы создали на прошлом шаге.
// Если вы вставили его в этот же файл, то импорт не нужен.

class SeedPhraseScreen extends StatefulWidget {
  const SeedPhraseScreen({super.key});

  @override
  State<SeedPhraseScreen> createState() => _SeedPhraseScreenState();
}

class _SeedPhraseScreenState extends State<SeedPhraseScreen> {
  List<String> _words = [];
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    // Генерируем 12 слов при открытии экрана
    _words = SeedPhraseGenerator.generate12Words();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Функция сохранения фразы одной строкой через пробел
  Future<void> _savePhraseAndContinue() async {
    if (_prefs != null) {
      final phraseString = _words.join(' ');
      await _prefs!.setString('user_seed_phrase', phraseString);
      
      _showSnackBar(AppStrings.phraseSavedInMemory, AppColors.success);
      
      // Переходим на следующий экран макета
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ErrorScreen()),
      );
    }
  }

  // Копирование фразы в буфер обмена телефона
  void _copyToClipboard() {
    final phraseString = _words.join(' ');
    Clipboard.setData(ClipboardData(text: phraseString));
    _showSnackBar(AppStrings.phraseCopied, AppColors.primary);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Заголовок из словаря
              Text(
                AppStrings.seedTitle,
                style: AppTextStyles.title.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Подзаголовок
              Text(
                AppStrings.seedSubtitle,
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              
              const Spacer(flex: 1),

              // Красивая сетка 12 слов (2 колонки) как в Tonkeeper
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,         // Две колонки
                  mainAxisSpacing: 12,       // Отступы по вертикали
                  crossAxisSpacing: 16,      // Отступы по горизонтали
                  childAspectRatio: 3.5,     // Пропорции карточки слова
                ),
                itemCount: _words.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface, // Темно-серый фон плашки
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        // Номер слова (серый)
                        SizedBox(
                          width: 25,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: AppColors.textSecondary.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Само слово (белое)
                        Expanded(
                          child: Text(
                            _words[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const Spacer(flex: 1),

              // Кнопка копирования
              TextButton.icon(
                onPressed: _copyToClipboard,
                icon: const Icon(Icons.copy, color: AppColors.primary, size: 20),
                label: const Text(
                  AppStrings.btnCopyPhrase,
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ),
              
              const SizedBox(height: 20),

              // Блок предупреждения (Warning box)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppStrings.seedWarning,
                        style: TextStyle(color: AppColors.error.withOpacity(0.9), fontSize: 13, height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Главная синяя кнопка продолжения
              ElevatedButton(
                onPressed: _savePhraseAndContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  AppStrings.btnPhraseSaved,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Вставьте класс "SeedPhraseGenerator" (который мы создали на прошлом шаге) прямо сюда ниже, 
// если вы еще не вынесли его в отдельный файл.
