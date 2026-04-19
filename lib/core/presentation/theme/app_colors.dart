import 'package:flutter/material.dart';

/// Design tokens from Figma Mobile App (WS-A MCP `get_design_context`).
abstract final class AppColors {
  static const Color primary900 = Color(0xFF1F4D73);
  static const Color primary800 = Color(0xFF276291);
  static const Color primary700 = Color(0xFF307AB5);
  static const Color primary600 = Color(0xFF3A92D9);
  static const Color primary100 = Color(0xFFD2EBFF);
  static const Color primary50 = Color(0xFFECF7FF);
  static const Color darkGray600 = Color(0xFF373737);
  static const Color white = Color(0xFFFFFFFF);

  static const LinearGradient glassPanelGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xBADDECF7), Color(0xBAD0EEFF)],
  );
}
