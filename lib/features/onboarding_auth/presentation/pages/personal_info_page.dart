import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4652 — Login: New Personal Information (WS-A A5)
class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _lastName = TextEditingController();
  final _firstName = TextEditingController();
  final _dob = TextEditingController(text: '27/07/2005');
  final _address = TextEditingController();
  final _id = TextEditingController();
  final _insurance = TextEditingController();

  @override
  void dispose() {
    _lastName.dispose();
    _firstName.dispose();
    _dob.dispose();
    _address.dispose();
    _id.dispose();
    _insurance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      maxPanelHeightFraction: 0.88,
      panel: Form(
        key: _formKey,
        child: EverwellAuthPanelLayout(
          header: const EverwellAuthPanelTitle('THÔNG TIN CÁ NHÂN'),
          scrollable: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _tf(
                      'Họ',
                      _lastName,
                      (v) => v == null || v.isEmpty ? 'Bắt buộc' : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _tf(
                      'Tên',
                      _firstName,
                      (v) => v == null || v.isEmpty ? 'Bắt buộc' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _tf(
                'Ngày sinh',
                _dob,
                (v) => v == null || v.isEmpty ? 'Bắt buộc' : null,
              ),
              const SizedBox(height: 12),
              _tf(
                'Địa chỉ',
                _address,
                (v) => v == null || v.isEmpty ? 'Bắt buộc' : null,
              ),
              const SizedBox(height: 12),
              _tf(
                'Số CCCD',
                _id,
                (v) => v == null || v.isEmpty ? 'Bắt buộc' : null,
              ),
              const SizedBox(height: 12),
              _tf(
                'Số thẻ BHXH',
                _insurance,
                (v) => v == null || v.isEmpty ? 'Bắt buộc' : null,
              ),
            ],
          ),
          footer: Row(
            children: [
              Expanded(
                child: EverwellPrimaryButton(
                  label: 'Quét CCCD',
                  onPressed: () => context.push(AppRoutes.onboardingNfcInfo),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: EverwellPrimaryButton(
                  label: 'Tiếp tục',
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    context.push(AppRoutes.onboardingAvatar);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tf(
    String label,
    TextEditingController c,
    String? Function(String?) validator,
  ) {
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
        const SizedBox(height: 8),
        TextFormField(
          controller: c,
          decoration: const InputDecoration(),
          validator: validator,
        ),
      ],
    );
  }
}
