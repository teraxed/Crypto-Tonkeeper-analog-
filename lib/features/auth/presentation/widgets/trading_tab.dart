import 'package:Crypto/features/config/theme/app_colors.dart';
import 'package:Crypto/features/config/theme/app_strings.dart';
import 'package:flutter/material.dart';

class TradingTab extends StatelessWidget {
  const TradingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              AppStrings.tradingTitle,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppStrings.tradingSoon,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}