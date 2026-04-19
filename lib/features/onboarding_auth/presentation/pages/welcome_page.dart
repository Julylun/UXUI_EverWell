import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4609 — Welcome (WS-A A1)
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      panel: EverwellAuthPanelLayout(
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Xin chào,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: AppColors.primary900,
              ),
            ),
            const Text(
              'Người dùng mới',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w700,
                color: AppColors.primary900,
              ),
            ),
          ],
        ),
        headerSpacingAfter: 16,
        scrollable: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EVERWELL',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGray600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Là một ứng dụng chăm sóc sức khỏe toàn diện, an toàn, tổng quát',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray600,
              ),
            ),
          ],
        ),
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EverwellPrimaryButton(
              label: 'Bắt đầu',
              onPressed: () => context.push(AppRoutes.authLoginReady),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => context.push(AppRoutes.authRegister),
                child: const Text(
                  'Đăng ký tài khoản',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary900,
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
