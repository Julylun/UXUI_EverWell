import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/app_scope.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4748 — Register: information (WS-A A14)
class RegisterInformationPage extends StatefulWidget {
  const RegisterInformationPage({super.key});

  @override
  State<RegisterInformationPage> createState() =>
      _RegisterInformationPageState();
}

class _RegisterInformationPageState extends State<RegisterInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      panel: Form(
        key: _formKey,
        child: EverwellAuthPanelLayout(
          header: const EverwellAuthPanelTitle('ĐĂNG KÝ'),
          headerSpacingAfter: 20,
          scrollable: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _field(
                label: 'Địa chỉ email',
                child: TextFormField(
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
              ),
              const SizedBox(height: 16),
              _field(
                label: 'Tên đăng nhập',
                child: TextFormField(
                  controller: _username,
                  decoration: const InputDecoration(
                    hintText: 'Tên đăng nhập',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Nhập tên đăng nhập';
                    }
                    if (v.trim().length < 4) {
                      return 'Tối thiểu 4 ký tự';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              _field(
                label: 'Mật khẩu',
                child: TextFormField(
                  controller: _password,
                  obscureText: _obscure1,
                  decoration: InputDecoration(
                    hintText: '••••••',
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscure1 = !_obscure1),
                      icon: Icon(
                        _obscure1
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.length < 6) {
                      return 'Mật khẩu tối thiểu 6 ký tự';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              _field(
                label: 'Nhập lại mật khẩu',
                child: TextFormField(
                  controller: _confirm,
                  obscureText: _obscure2,
                  decoration: InputDecoration(
                    hintText: '••••••',
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscure2 = !_obscure2),
                      icon: Icon(
                        _obscure2
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v != _password.text) return 'Mật khẩu không khớp';
                    return null;
                  },
                ),
              ),
            ],
          ),
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EverwellPrimaryButton(
                label: _loading ? 'Đang gửi...' : 'Đăng ký',
                onPressed: _loading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        setState(() => _loading = true);
                        try {
                          await AppScope.authRepository.requestRegisterOtp(
                            _email.text.trim(),
                          );
                          if (!context.mounted) return;
                          context.push(AppRoutes.authRegisterOtp);
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
                onPressed: () => context.push(AppRoutes.authLogin),
                child: const Text(
                  'Tôi đã có tài khoản',
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
