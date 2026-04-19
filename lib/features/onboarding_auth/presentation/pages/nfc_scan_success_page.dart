import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4699 — Login: Scan successfully (WS-A A9)
class NfcScanSuccessPage extends StatelessWidget {
  const NfcScanSuccessPage({super.key});

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
              'Quét thông tin thành công',
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
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: AppColors.primary800,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 40),
          ),
        ),
        footer: EverwellPrimaryButton(
          label: 'Tiếp tục',
          onPressed: () => context.go(AppRoutes.onboardingImportEmr),
        ),
      ),
    );
  }
}
