import 'package:Crypto/features/config/theme/app_colors.dart';
import 'package:Crypto/features/config/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error', style: AppTextStyles.balance),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('return'),
            ),
          ],
        ),
      ),
    );
  }
}
