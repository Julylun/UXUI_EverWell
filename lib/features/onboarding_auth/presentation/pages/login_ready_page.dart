import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4620 — Login: Ready to use (WS-A A2)
class LoginReadyPage extends StatelessWidget {
  const LoginReadyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      panel: EverwellAuthPanelLayout(
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chào mừng,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: AppColors.primary900,
              ),
            ),
            const Text(
              'Hoang Luan',
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
              'Bạn đã sẵn sàng để sử dụng',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'EVERWELL',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGray600,
              ),
            ),
          ],
        ),
        footer: EverwellPrimaryButton(
          label: 'Bắt đầu',
          onPressed: () => context.push(AppRoutes.authLogin),
        ),
      ),
    );
  }
}
