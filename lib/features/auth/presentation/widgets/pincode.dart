import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';

// NEW: ключ, что кошелёк уже создан (ставится в wallet_customization_screen)
const String kWalletCreated = 'wallet_created';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String _currentPin = "";
  String _firstEnteredPin = ""; // Хранит первый ввод при создании пароля
  final int _pinLength = 4;

  bool _isLoading = true;          // ждём загрузку SharedPreferences
  bool _isPasswordCreated = false; // Существует ли уже сохраненный пароль
  bool _isConfirming = false;      // Находимся ли мы на этапе подтверждения кода
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  // Инициализируем хранилище и проверяем, создан ли кошелёк и пароль
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    // NEW: кошелька нет -> сразу на регистрацию
    final walletCreated = _prefs?.getBool(kWalletCreated) ?? false;
    if (!walletCreated) {
      if (!mounted) return;
      context.go('/auth');
      return;
    }

    final savedPin = _prefs?.getString('user_pin');

    if (!mounted) return;
    setState(() {
      _isPasswordCreated = savedPin != null;
      _isLoading = false;
    });
  }

  void _onNumberPressed(int number) {
    if (_currentPin.length < _pinLength) {
      setState(() {
        _currentPin += number.toString();
      });

      if (_currentPin.length == _pinLength) {
        _handlePinCompletion(_currentPin);
      }
    }
  }

  void _onDeletePressed() {
    if (_currentPin.isNotEmpty) {
      setState(() {
        _currentPin = _currentPin.substring(0, _currentPin.length - 1);
      });
    }
  }

  // Основная логика обработки заполненного ПИН-кода
  void _handlePinCompletion(String pin) async {
    if (!_isPasswordCreated) {
      // СЦЕНАРИЙ А: ПЕРВЫЙ ЗАПУСК (Создание пароля)
      if (!_isConfirming) {
        // Шаг 1: Запоминаем первый ввод и просим повторить
        setState(() {
          _firstEnteredPin = pin;
          _isConfirming = true;
          _currentPin = ""; // Сбрасываем точки для второго ввода
        });
      } else {
        // Шаг 2: Проверяем, совпали ли пароли при подтверждении
        if (pin == _firstEnteredPin) {
          // Пароли совпали! Сохраняем в память
          await _prefs?.setString('user_pin', pin);
          if (!mounted) return;
          _showSnackBar('Пароль успешно создан!', AppColors.success);
          _navigateToNextScreen();
        } else {
          // Пароли не совпали
          _showSnackBar('Пароли не совпали. Попробуйте сначала.', AppColors.error);
          setState(() {
            _isConfirming = false;
            _firstEnteredPin = "";
            _currentPin = "";
          });
        }
      }
    } else {
      // СЦЕНАРИЙ Б: ПОВТОРНЫЙ ВХОД (Проверка пароля)
      final savedPin = _prefs?.getString('user_pin');
      if (pin == savedPin) {
        _navigateToNextScreen();
      } else {
        _showSnackBar('Неверный ПИН-код!', AppColors.error);
        setState(() {
          _currentPin = "";
        });
      }
    }
  }

  void _navigateToNextScreen() {
    context.go('/home');
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

  // Динамический текст заголовка в зависимости от состояния приложения
  String _getScreenTitle() {
    if (!_isPasswordCreated) {
      return _isConfirming ? 'Повторите ПИН-код' : 'Создайте ПИН-код';
    }
    return 'Введите ПИН-код для входа';
  }

  @override
  Widget build(BuildContext context) {
    // Пока грузится хранилище, показываем пустой фон (без мигания заголовка)
    if (_isLoading) {
      return const Scaffold(backgroundColor: AppColors.background);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Динамический заголовок
            Text(
              _getScreenTitle(),
              style: AppTextStyles.title.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 30),

            // Точки-индикаторы
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pinLength, (index) {
                bool isFilled = index < _currentPin.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: isFilled ? AppColors.primary : AppColors.textSecondary,
                      width: 2,
                    ),
                  ),
                );
              }),
            ),

            const Spacer(flex: 2),

            // Цифровая клавиатура
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 1,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    // Кнопка сброса памяти (для тестов, чтобы стереть пароль)
                    return IconButton(
                      icon: const Icon(Icons.refresh, color: AppColors.textSecondary, size: 28),
                      onPressed: () async {
                        await _prefs?.remove('user_pin');
                        if (!mounted) return;
                        _showSnackBar('Пароль стерт из памяти устройства!', AppColors.textSecondary);
                        setState(() {
                          _isPasswordCreated = false;
                          _isConfirming = false;
                          _firstEnteredPin = "";
                          _currentPin = "";
                        });
                      },
                    );
                  } else if (index == 10) {
                    return _buildNumButton(0);
                  } else if (index == 11) {
                    return IconButton(
                      icon: const Icon(Icons.backspace_outlined, color: Colors.white, size: 28),
                      onPressed: _onDeletePressed,
                    );
                  } else {
                    return _buildNumButton(index + 1);
                  }
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildNumButton(int number) {
    return InkWell(
      onTap: () => _onNumberPressed(number),
      customBorder: const CircleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$number',
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}