import 'package:flutter/material.dart';

import '../../core/presentation/theme/app_colors.dart';

ThemeData buildEverwellTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary900,
      primary: AppColors.primary900,
      surface: AppColors.primary50,
    ),
  );
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.primary900,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.primary50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 23, vertical: 22),
    ),
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.primary900,
      displayColor: AppColors.primary900,
    ),
  );
}
