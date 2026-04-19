import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4669 — Login: Choose Avatar (WS-A A6)
class ChooseAvatarPage extends StatelessWidget {
  const ChooseAvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      panel: EverwellAuthPanelLayout(
        header: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EverwellAuthPanelTitle('THÔNG TIN CÁ NHÂN'),
            SizedBox(height: 6),
            Text(
              'Chọn ảnh đại diện',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary900,
              ),
            ),
          ],
        ),
        headerSpacingAfter: 24,
        scrollable: Center(
          child: Container(
            width: 144,
            height: 144,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary50,
              border: Border.all(color: AppColors.primary900, width: 2),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.face_retouching_natural,
                  size: 40,
                  color: AppColors.primary900,
                ),
                SizedBox(height: 8),
                Text(
                  'Chọn ảnh',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary900,
                  ),
                ),
              ],
            ),
          ),
        ),
        footer: EverwellPrimaryButton(
          label: 'Tiếp tục',
          onPressed: () => context.push(AppRoutes.onboardingImportEmr),
        ),
      ),
    );
  }
}
