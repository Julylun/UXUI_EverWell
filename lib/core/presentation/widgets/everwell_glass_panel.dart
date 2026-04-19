import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Frosted bottom sheet panel (Figma glass + rounded top ~50).
class EverwellGlassPanel extends StatelessWidget {
  const EverwellGlassPanel({
    super.key,
    required this.child,
    this.maxHeightFraction = 0.72,
  });

  final Widget child;
  final double maxHeightFraction;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    return LayoutBuilder(
      builder: (context, constraints) {
        final fromParent = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : screenH;
        final cap = (screenH * maxHeightFraction).clamp(0.0, fromParent);
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: cap),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppColors.glassPanelGradient,
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.5),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 6,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
