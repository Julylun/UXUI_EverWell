import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4689 — Login: New Personal Information by NFC (WS-A A8)
class NfcPersonalInfoPage extends StatelessWidget {
  const NfcPersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      panel: EverwellAuthPanelLayout(
        header: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EverwellAuthPanelTitle('THÔNG TIN CÁ NHÂN'),
            SizedBox(height: 8),
            Text(
              'Sử dụng thẻ CCCD đặt sau điện thoại đến khi chuyển sang trang quét thì giữ yên',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary900,
              ),
            ),
          ],
        ),
        headerSpacingAfter: 16,
        scrollable: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFF2F3A45),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.nfc, color: Colors.white, size: 72),
          ),
        ),
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EverwellPrimaryButton(
              label: 'Tiếp tục quét',
              onPressed: () => context.push(AppRoutes.onboardingNfcScan),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                'Huỷ bỏ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
