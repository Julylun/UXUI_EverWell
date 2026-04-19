import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/figma_mcp_auth_assets.dart';

/// Nền hero WS-A: ảnh bundle offline (`assets/images/auth/`) + gradient dự phòng nếu load asset lỗi.
class EverwellAuthBackground extends StatelessWidget {
  const EverwellAuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Image.asset(
            FigmaMcpAuthAssets.welcomeHeroBackground,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            gaplessPlayback: true,
            filterQuality: FilterQuality.medium,
            errorBuilder: (context, error, stackTrace) =>
                const _GradientFallback(),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.12),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.06),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GradientFallback extends StatelessWidget {
  const _GradientFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B4D59), Color(0xFF5BA3C6), Color(0xFFE8B4C8)],
        ),
      ),
    );
  }
}

class EverwellAuthHeader extends StatelessWidget {
  const EverwellAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: 120,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'EVERWELL',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
