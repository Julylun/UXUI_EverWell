import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/app_scope.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4642 — Forget Password: New passsword (WS-A A4)
class ForgotPasswordNewPasswordPage extends StatefulWidget {
  const ForgotPasswordNewPasswordPage({super.key});

  @override
  State<ForgotPasswordNewPasswordPage> createState() =>
      _ForgotPasswordNewPasswordPageState();
}

class _ForgotPasswordNewPasswordPageState
    extends State<ForgotPasswordNewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _p1 = TextEditingController();
  final _p2 = TextEditingController();
  bool _ob1 = true;
  bool _ob2 = true;
  bool _loading = false;

  @override
  void dispose() {
    _p1.dispose();
    _p2.dispose();
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
              _field(
                label: 'Mật khẩu',
                child: TextFormField(
                  controller: _p1,
                  obscureText: _ob1,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _ob1 = !_ob1),
                      icon: Icon(
                        _ob1
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.length < 6) return 'Tối thiểu 6 ký tự';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              _field(
                label: 'Nhập lại mật khẩu',
                child: TextFormField(
                  controller: _p2,
                  obscureText: _ob2,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _ob2 = !_ob2),
                      icon: Icon(
                        _ob2
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v != _p1.text) return 'Mật khẩu không khớp';
                    return null;
                  },
                ),
              ),
            ],
          ),
          footer: EverwellPrimaryButton(
            label: _loading ? 'Đang lưu...' : 'Đổi mật khẩu',
            onPressed: _loading
                ? null
                : () async {
                    if (!_formKey.currentState!.validate()) return;
                    setState(() => _loading = true);
                    try {
                      await AppScope.authRepository.resetPassword(
                        _p1.text,
                        _p2.text,
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đổi mật khẩu thành công (mock).'),
                        ),
                      );
                      context.go(AppRoutes.authLogin);
                    } catch (_) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Không đổi được mật khẩu.'),
                        ),
                      );
                    } finally {
                      if (mounted) setState(() => _loading = false);
                    }
                  },
          ),
        ),
      ),
    );
  }

  static Widget _field({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primary900,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
