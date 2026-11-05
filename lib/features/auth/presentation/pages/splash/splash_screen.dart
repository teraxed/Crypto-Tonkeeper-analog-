import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "../../../../config/theme/app_colors.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToPin();
  }

  // Через 2 секунды идём на ПИН-код, он сам решит: вход или регистрация
  Future<void> _navigateToPin() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    context.go('/pin'); // CHANGED: go вместо push, сплэш убирается из стека
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Image.asset(
          'assets/splash/logo.png',
          width: 280,
          height: 280,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}