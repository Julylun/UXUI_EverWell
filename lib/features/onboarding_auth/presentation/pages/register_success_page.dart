import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4740 — Register: Successful (WS-A A13)
class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      panel: EverwellAuthPanelLayout(
        header: const EverwellAuthPanelTitle('ĐĂNG KÝ'),
        headerSpacingAfter: 16,
        scrollable: const Text(
          'Bạn đã đăng ký thành công tài khoản! Quay lại trang chủ để đăng nhập',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primary900,
          ),
        ),
        footer: EverwellPrimaryButton(
          label: 'Đăng nhập',
          onPressed: () => context.go(AppRoutes.authLogin),
        ),
      ),
    );
  }
}
