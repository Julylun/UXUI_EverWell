import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/app_scope.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';
import '../view_models/login_view_model.dart';

// Figma node-id: 806:4631 — Login (WS-A A3)
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  late final LoginViewModel _vm = LoginViewModel(AppScope.authRepository);
  bool _obscure = true;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      panel: Form(
        key: _formKey,
        child: ListenableBuilder(
          listenable: _vm,
          builder: (context, _) {
            return EverwellAuthPanelLayout(
              header: const EverwellAuthPanelTitle('ĐĂNG NHẬP'),
              headerSpacingAfter: 24,
              scrollable: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _labeled(
                    label: 'Tên đăng nhập',
                    child: TextFormField(
                      controller: _username,
                      decoration: const InputDecoration(
                        hintText: 'Nhập tên đăng nhập',
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Vui lòng nhập tên đăng nhập';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  _labeled(
                    label: 'Mật khẩu',
                    trailing: TextButton(
                      onPressed: () =>
                          context.push(AppRoutes.authForgotEmail),
                      child: const Text(
                        'Quên mật khẩu?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary700,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _password,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => _obscure = !_obscure),
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (v.length < 6) {
                          return 'Mật khẩu tối thiểu 6 ký tự';
                        }
                        return null;
                      },
                    ),
                  ),
                  if (_vm.errorMessage != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _vm.errorMessage!,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ],
                ],
              ),
              footer: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EverwellPrimaryButton(
                    label: _vm.isLoading
                        ? 'Đang đăng nhập...'
                        : 'Đăng nhập',
                    onPressed: _vm.isLoading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) return;
                            final ok = await _vm.submit(
                              _username.text,
                              _password.text,
                            );
                            if (!context.mounted) return;
                            if (ok) {
                              context.go(AppRoutes.onboardingPersonalInfo);
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
            );
          },
        ),
      ),
    );
  }

  static Widget _labeled({
    required String label,
    required Widget child,
    Widget? trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary900,
                ),
              ),
            ),
            ?trailing,
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
