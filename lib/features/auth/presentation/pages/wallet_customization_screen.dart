import 'package:Crypto/features/config/theme/app_colors.dart';
import 'package:Crypto/features/config/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Встроенные иконки Flutter для тега кошелька
abstract class WalletIcons {
  static const List<IconData> all = [
    Icons.account_balance_wallet_rounded,
    Icons.diamond_rounded,
    Icons.rocket_launch_rounded,
    Icons.bolt_rounded,
    Icons.star_rounded,
    Icons.favorite_rounded,
    Icons.savings_rounded,
    Icons.currency_bitcoin_rounded,
    Icons.shield_rounded,
    Icons.lock_rounded,
    Icons.public_rounded,
    Icons.local_fire_department_rounded,
    Icons.pets_rounded,
    Icons.sports_esports_rounded,
    Icons.eco_rounded,
    Icons.flight_rounded,
  ];
}

class WalletCustomizationScreen extends StatefulWidget {
  const WalletCustomizationScreen({super.key});

  @override
  State<WalletCustomizationScreen> createState() =>
      _WalletCustomizationScreenState();
}

class _WalletCustomizationScreenState extends State<WalletCustomizationScreen> {
  // Ключи SharedPreferences
  static const String _kName = 'wallet_name';
  static const String _kColor = 'wallet_color_index';
  static const String _kIcon = 'wallet_icon_index';

  final TextEditingController _nameController = TextEditingController();
  SharedPreferences? _prefs;

  int _colorIndex = 0;
  int _iconIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController.text = AppStrings.customDefaultName;
    _load();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Загружаем сохранённые значения
  Future<void> _load() async {
    _prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _nameController.text =
          _prefs?.getString(_kName) ?? AppStrings.customDefaultName;
      _colorIndex = (_prefs?.getInt(_kColor) ?? 0)
          .clamp(0, AppColors.wallet.length - 1);
      _iconIndex = (_prefs?.getInt(_kIcon) ?? 0)
          .clamp(0, WalletIcons.all.length - 1);
    });
  }

  // Сохраняем и возвращаемся назад
  Future<void> _save() async {
    final name = _nameController.text.trim().isEmpty
        ? AppStrings.customDefaultName
        : _nameController.text.trim();

    await _prefs?.setString(_kName, name);
    await _prefs?.setInt(_kColor, _colorIndex);
    await _prefs?.setInt(_kIcon, _iconIndex);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.customSaved),
        duration: Duration(seconds: 1),
      ),
    );
    Navigator.of(context).maybePop();
  }

  // Заголовок секции
  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Превью кошелька (иконка в цветном круге + имя)
  Widget _buildPreview() {
    final color = AppColors.wallet[_colorIndex];
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(WalletIcons.all[_iconIndex], color: Colors.white, size: 48),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _nameController,
          builder: (context, value, _) {
            return Text(
              value.text.trim().isEmpty
                  ? AppStrings.customDefaultName
                  : value.text.trim(),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ],
    );
  }

  // Поле имени
  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      maxLength: 24,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surface,
        counterText: '',
        hintText: AppStrings.customNameHint,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  // Выбор цвета
  Widget _buildColorPicker() {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: List.generate(AppColors.wallet.length, (i) {
        final selected = i == _colorIndex;
        return GestureDetector(
          onTap: () => setState(() => _colorIndex = i),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.wallet[i],
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? Colors.white : Colors.transparent,
                width: 2.5,
              ),
            ),
            child: selected
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 22)
                : null,
          ),
        );
      }),
    );
  }

  // Выбор иконки
  Widget _buildIconPicker() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(WalletIcons.all.length, (i) {
        final selected = i == _iconIndex;
        return GestureDetector(
          onTap: () => setState(() => _iconIndex = i),
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Icon(
              WalletIcons.all[i],
              color: selected ? AppColors.primary : AppColors.textSecondary,
              size: 26,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
        ),
        title: const Text(
          AppStrings.customTitle,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Center(child: _buildPreview()),
                    const SizedBox(height: 32),
                    _sectionLabel(AppStrings.customNameLabel),
                    _buildNameField(),
                    const SizedBox(height: 24),
                    _sectionLabel(AppStrings.customColorLabel),
                    _buildColorPicker(),
                    const SizedBox(height: 24),
                    _sectionLabel(AppStrings.customIconLabel),
                    _buildIconPicker(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    AppStrings.customSave,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
