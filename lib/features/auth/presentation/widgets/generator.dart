import 'dart:math';
import 'package:Crypto/features/config/theme/app_colors.dart';
import 'package:Crypto/features/config/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class SeedPhraseGenerator {
  static const List<String> _wordList = [
    'apple', 'banana', 'crypto', 'diamond', 'energy', 'future', 'galaxy', 'honey', 
    'island', 'jungle', 'kitten', 'lemon', 'matrix', 'nature', 'ocean', 'planet', 
    'quantum', 'rocket', 'shadow', 'tiger', 'universe', 'victory', 'wizard', 'zebra',
    'alpha', 'bravo', 'charlie', 'delta', 'echo', 'foxtrot', 'golf', 'hotel'
  ];

  static List<String> generate12Words() {
    final random = Random();
    final Set<String> selectedWords = {};
    
    while (selectedWords.length < 12) {
      int index = random.nextInt(_wordList.length);
      selectedWords.add(_wordList[index]);
    }
    
    return selectedWords.toList();
  }
}

class Generator extends StatefulWidget {
  const Generator({super.key});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  static const Color _cardColor = Color(0xFF1C2230);
  static const Color _numberColor = Color(0xFF8E96A8);
  static const Color _accentColor = Color(0xFF45AEF5);
  static const int _checkCount = 3; // сколько слов спрашиваем

  late List<String> _words;

  // false = показ фразы, true = проверка
  bool _isChecking = false;

  // Номера слов (индексы), которые спрашиваем
  List<int> _checkIndexes = [];
  final List<TextEditingController> _controllers = [];

  // Сообщение об ошибке на экране проверки
  String? _error;

  @override
  void initState() {
    super.initState();
    _words = SeedPhraseGenerator.generate12Words();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  // Сгенерировать новую фразу
  void _regenerate() {
    setState(() => _words = SeedPhraseGenerator.generate12Words());
  }

  // Перейти к проверке: выбираем 3 случайных номера
  void _goToCheck() {
    for (final c in _controllers) {
      c.dispose();
    }
    _controllers.clear();

    final indexes = List<int>.generate(_words.length, (i) => i)..shuffle();
    _checkIndexes = indexes.take(_checkCount).toList()..sort();

    for (int i = 0; i < _checkCount; i++) {
      _controllers.add(TextEditingController());
    }

    setState(() {
      _error = null;
      _isChecking = true;
    });
  }

  // Вернуться от проверки к показу фразы
  void _backToWords() {
    setState(() {
      _error = null;
      _isChecking = false;
    });
  }

  // NEW: назад с экрана со словами (на предыдущий экран)
  void _backFromWords() {
    Navigator.of(context).maybePop();
  }

  // Проверка введённых слов
  void _verify() {
    bool ok = true;
    for (int i = 0; i < _checkCount; i++) {
      final input = _controllers[i].text.trim().toLowerCase();
      if (input != _words[_checkIndexes[i]]) {
        ok = false;
        break;
      }
    }

    if (ok) {
      context.push('/wallet-customization');
    } else {
      setState(() => _error = AppStrings.checkError);
    }
  }

  // Кнопка назад (общая для обоих экранов)
  Widget _backButton(VoidCallback onPressed) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white, size: 20),
      ),
    );
  }

  // Одна строка: номер + слово
  Widget _wordItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '${index + 1}.',
              style: const TextStyle(color: _numberColor, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              _words[index],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Большая кнопка внизу
  Widget _primaryButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ЭКРАН 1: показ фразы
  Widget _buildWordsStep() {
    final int half = _words.length ~/ 2;

    return Column(
      children: [
        _backButton(_backFromWords), // NEW
        const SizedBox(height: 8),
        const Text(
          AppStrings.seedTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          AppStrings.seedSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: _numberColor, fontSize: 16, height: 1.4),
        ),
        const SizedBox(height: 32),

        // Карточка со словами: две колонки
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [for (int i = 0; i < half; i++) _wordItem(i)],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    for (int i = half; i < _words.length; i++) _wordItem(i),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        TextButton.icon(
          onPressed: _regenerate,
          icon: const Icon(Icons.refresh_rounded, size: 18, color: _accentColor),
          label: const Text(
            AppStrings.btnRegenerate,
            style: TextStyle(color: _accentColor, fontSize: 16),
          ),
        ),

        const Spacer(),
        _primaryButton(AppStrings.btnNext, _goToCheck),
        const SizedBox(height: 24),
      ],
    );
  }

  // ЭКРАН 2: проверка слов
  Widget _buildCheckStep() {
    return Column(
      children: [
        _backButton(_backToWords),
        const SizedBox(height: 8),
        const Text(
          AppStrings.checkTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${AppStrings.checkSubtitle} ${_checkIndexes.map((i) => i + 1).join(', ')}.',
          textAlign: TextAlign.center,
          style: const TextStyle(color: _numberColor, fontSize: 16, height: 1.4),
        ),
        const SizedBox(height: 32),

        // Поля ввода
        for (int i = 0; i < _checkCount; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextField(
              controller: _controllers[i],
              autocorrect: false,
              enableSuggestions: false,
              textInputAction:
                  i == _checkCount - 1 ? TextInputAction.done : TextInputAction.next,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                filled: true,
                fillColor: _cardColor,
                prefixIcon: SizedBox(
                  width: 56,
                  child: Center(
                    child: Text(
                      '${_checkIndexes[i] + 1}.',
                      style: const TextStyle(color: _numberColor, fontSize: 16),
                    ),
                  ),
                ),
                hintText: AppStrings.checkWordHint,
                hintStyle: const TextStyle(color: _numberColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: _accentColor, width: 1.5),
                ),
              ),
            ),
          ),

        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
          ),

        const Spacer(),
        _primaryButton(AppStrings.btnConfirm, _verify),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _isChecking ? _buildCheckStep() : _buildWordsStep(),
        ),
      ),
    );
  }
}