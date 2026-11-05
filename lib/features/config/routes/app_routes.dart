import 'package:go_router/go_router.dart';
import 'package:Crypto/features/core/error/error_screen.dart';
import 'package:Crypto/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:Crypto/features/auth/presentation/widgets/generator.dart';
import 'package:Crypto/features/auth/presentation/widgets/pincode.dart';
import 'package:Crypto/features/auth/presentation/pages/wallet_customization_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/pin', builder: (context, state) => const PinCodeScreen()),
    GoRoute(path: '/generator', builder: (context, state) => const Generator()),
    GoRoute(
      path: '/wallet-customization',
      builder: (context, state) => const WalletCustomizationScreen(),
    ),
    GoRoute(path: '/error', builder: (context, state) => const ErrorScreen()),
  ],
);
