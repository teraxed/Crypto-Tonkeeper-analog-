import 'package:Crypto/features/config/theme/app_colors.dart';
import 'package:Crypto/features/config/theme/app_strings.dart';
import 'package:Crypto/features/auth/data/data_sources/yields_service.dart';
import 'package:Crypto/features/auth/data/models/yield_model.dart';
import 'package:Crypto/features/auth/presentation/pages/wallet_customization_screen.dart'; // для WalletIcons
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // Те же ключи, что в экране кастомизации
  static const String _kName = 'wallet_name';
  static const String _kColor = 'wallet_color_index';
  static const String _kIcon = 'wallet_icon_index';

  // Баланс пока хранится в переменной
  double _balance = 0.0;

  String _name = AppStrings.customDefaultName;
  int _colorIndex = 0;
  int _iconIndex = 0;

  // Данные доходности из API
  List<YieldAsset> _yields = [];
  bool _yieldsLoading = true;
  bool _yieldsError = false;

  @override
  void initState() {
    super.initState();
    _loadWallet();
    _loadYields();
  }

  // Загружаем имя, цвет и иконку кошелька
  Future<void> _loadWallet() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _name = prefs.getString(_kName) ?? AppStrings.customDefaultName;
      _colorIndex =
          (prefs.getInt(_kColor) ?? 0).clamp(0, AppColors.wallet.length - 1);
      _iconIndex =
          (prefs.getInt(_kIcon) ?? 0).clamp(0, WalletIcons.all.length - 1);
    });
  }

  // Загружаем доходность
  Future<void> _loadYields() async {
    setState(() {
      _yieldsLoading = true;
      _yieldsError = false;
    });
    try {
      final data = await YieldsService.fetch();
      if (!mounted) return;
      setState(() {
        _yields = data;
        _yieldsLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _yieldsLoading = false;
        _yieldsError = true;
      });
    }
  }

  // Шапка: аватар кошелька + имя (как в Tonkeeper)
  Widget _buildHeader() {
    final color = AppColors.wallet[_colorIndex];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: GestureDetector(
        onTap: () async {
          await context.push('/wallet-customization');
          _loadWallet();
        },
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(WalletIcons.all[_iconIndex],
                  color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            Text(
              _name,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.textSecondary, size: 22),
          ],
        ),
      ),
    );
  }

  // Баланс (берётся из переменной _balance)
  Widget _buildBalance() {
    return Column(
      children: [
        const SizedBox(height: 32),
        const Text(
          AppStrings.mainBalance,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          '${_balance.toStringAsFixed(2)} ${AppStrings.homeCurrency}',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Одна круглая кнопка действия
  Widget _actionButton(IconData icon, String label) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // Ряд кнопок: отправить, получить, купить, обменять
  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Row(
        children: [
          _actionButton(Icons.arrow_upward_rounded, AppStrings.send),
          _actionButton(Icons.arrow_downward_rounded, AppStrings.receive),
          _actionButton(Icons.add_rounded, AppStrings.buy),
          _actionButton(Icons.swap_horiz_rounded, AppStrings.swap),
        ],
      ),
    );
  }

  // Заголовок секции
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Карточка актива TON (баланс из переменной)
  Widget _buildAssetTile() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.diamond_rounded,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.homeCurrency,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Toncoin',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            _balance.toStringAsFixed(2),
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Строка доходности одного актива
  Widget _yieldTile(YieldAsset y) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Круг с первой буквой тикера
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            child: Center(
              child: Text(
                y.asset.substring(0, 1),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  y.asset,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  y.platform ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            '${y.bestApy!.toStringAsFixed(2)}% APY',
            style: const TextStyle(
              color: AppColors.success,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Секция доходности (загрузка / ошибка / список)
  Widget _buildYields() {
    if (_yieldsLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (_yieldsError) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Column(
            children: [
              const Text(
                AppStrings.homeYieldError,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              TextButton(
                onPressed: _loadYields,
                child: const Text(
                  AppStrings.homeRetry,
                  style: TextStyle(color: AppColors.primary, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(children: _yields.map(_yieldTile).toList());
  }

  // История (пока пусто)
  Widget _buildHistory() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Text(
          AppStrings.homeNoHistory,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold теперь в HomeScreen, здесь только содержимое вкладки
    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.surface,
        onRefresh: _loadYields,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Center(child: _buildBalance()),
              _buildActions(),
              _sectionTitle(AppStrings.assets),
              _buildAssetTile(),
              _sectionTitle(AppStrings.homeYieldTitle),
              _buildYields(),
              _sectionTitle(AppStrings.history),
              _buildHistory(),
            ],
          ),
        ),
      ),
    );
  }
}