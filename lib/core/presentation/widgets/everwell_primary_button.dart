import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class EverwellPrimaryButton extends StatelessWidget {
  const EverwellPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = EverwellPrimaryButtonVariant.filled,
  });

  final String label;
  final VoidCallback? onPressed;
  final EverwellPrimaryButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final style = switch (variant) {
      EverwellPrimaryButtonVariant.filled => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary900,
        foregroundColor: AppColors.primary50,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        shadowColor: Colors.black26,
      ),
      EverwellPrimaryButtonVariant.soft => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary100,
        foregroundColor: AppColors.primary900,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    };
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: style,
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

enum EverwellPrimaryButtonVariant { filled, soft }
