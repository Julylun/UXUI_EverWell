import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/app_scope.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../view_models/nfc_scan_view_model.dart';

// Figma node-id: 806:4709 — Login: Scaning NFC (WS-A A10)
class NfcScanningPage extends StatefulWidget {
  const NfcScanningPage({super.key});

  @override
  State<NfcScanningPage> createState() => _NfcScanningPageState();
}

class _NfcScanningPageState extends State<NfcScanningPage> {
  late final NfcScanViewModel _vm = NfcScanViewModel(
    AppScope.onboardingRepository,
  );
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _vm.addListener(_onVm);
    _vm.start();
  }

  void _onVm() {
    if (_vm.isComplete && !_navigated) {
      _navigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.go(AppRoutes.onboardingNfcSuccess);
      });
    }
  }

  @override
  void dispose() {
    _vm.removeListener(_onVm);
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EverwellAuthScaffold(
      panel: ListenableBuilder(
        listenable: _vm,
        builder: (context, _) {
          return EverwellAuthPanelLayout(
            header: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EverwellAuthPanelTitle('THÔNG TIN CÁ NHÂN'),
                SizedBox(height: 6),
                Text(
                  'Đang quét, vui lòng giữ yên',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary900,
                  ),
                ),
              ],
            ),
            headerSpacingAfter: 16,
            scrollable: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F3A45),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.nfc, color: Colors.white, size: 80),
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: LinearProgressIndicator(
                    value: _vm.progress.clamp(0.0, 1.0),
                    minHeight: 12,
                    backgroundColor: AppColors.primary50,
                    color: AppColors.primary600,
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
            footer: null,
          );
        },
      ),
    );
  }
}
