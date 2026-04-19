import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/app_scope.dart';
import '../../../../app/router/routes.dart';
import '../../data/services/mock_auth_service.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';
import '../view_models/otp_input_view_model.dart';
import '../widgets/otp_panel.dart';

// Figma node-id: 806:4768 — Forget Password: OTP (WS-A A16)
class ForgotPasswordOtpPage extends StatefulWidget {
  const ForgotPasswordOtpPage({super.key});

  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  late final OtpInputViewModel _vm = OtpInputViewModel(AppScope.authRepository);

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      maxPanelHeightFraction: 0.85,
      panel: ListenableBuilder(
        listenable: _vm,
        builder: (context, _) {
          return EverwellAuthPanelLayout(
            header: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const EverwellAuthPanelTitle('QUÊN MẬT KHẨU'),
                const SizedBox(height: 8),
                const Text(
                  'Nhập OTP từ email để hoàn tất',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gợi ý mock: ${MockAuthService.mockOtp}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary900.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            headerSpacingAfter: 16,
            scrollable: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OtpDigitsRow(digits: _vm.digits),
                const SizedBox(height: 20),
                OtpKeypad(
                  onDigit: _vm.addDigit,
                  onBackspace: _vm.backspace,
                ),
              ],
            ),
            footer: EverwellPrimaryButton(
              label: _vm.isSubmitting ? 'Đang xác nhận...' : 'Xác nhận',
              onPressed: _vm.isSubmitting
                  ? null
                  : () async {
                      final ok = await _vm.submit();
                      if (!context.mounted) return;
                      if (ok) {
                        context.push(AppRoutes.authForgotNewPassword);
                      } else if (_vm.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(_vm.errorMessage!)),
                        );
                      }
                    },
            ),
          );
        },
      ),
    );
  }
}
