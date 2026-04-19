import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/app_scope.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4730 — Forget Password: Email (WS-A A12)
class ForgotPasswordEmailPage extends StatefulWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      panel: Form(
        key: _formKey,
        child: EverwellAuthPanelLayout(
          header: const EverwellAuthPanelTitle('QUÊN MẬT KHẨU'),
          headerSpacingAfter: 24,
          scrollable: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Địa chỉ email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary900,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'email@example.com',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Nhập email';
                  if (!v.contains('@')) return 'Email không hợp lệ';
                  return null;
                },
              ),
            ],
          ),
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EverwellPrimaryButton(
                label: _loading ? 'Đang gửi...' : 'Xác nhận',
                onPressed: _loading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        setState(() => _loading = true);
                        try {
                          await AppScope.authRepository.requestForgotOtp(
                            _email.text.trim(),
                          );
                          if (!context.mounted) return;
                          context.push(AppRoutes.authForgotOtp);
                        } catch (_) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Không gửi được OTP (mock).'),
                            ),
                          );
                        } finally {
                          if (mounted) setState(() => _loading = false);
                        }
                      },
              ),
              TextButton(
                onPressed: () => context.push(AppRoutes.authRegister),
                child: const Text(
                  'Tôi chưa có tài khoản',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
