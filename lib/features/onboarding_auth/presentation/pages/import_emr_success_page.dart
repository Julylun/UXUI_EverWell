import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/app_scope.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/import_emr_assets.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4679 — Login: Import EMRs successfully (WS-A A7)
class ImportEmrSuccessPage extends StatelessWidget {
  const ImportEmrSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final src = AppScope.onboardingRepository.lastImportSource ?? 'nguồn';
    final label = switch (src) {
      'VNEID' => 'VNEID',
      'GOV' => 'GOV',
      'CHO_RAY' => 'CHO RAY',
      _ => src,
    };
    final logoPath = ImportEmrAssets.tilePathForSource(src);
    return EverwellAuthScaffold(
      panel: EverwellAuthPanelLayout(
        header: const EverwellAuthPanelTitle('NHẬP DỮ LIỆU BỆNH ÁN'),
        headerSpacingAfter: 20,
        scrollable: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green.shade700,
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primary50,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: SizedBox(
                            width: 36,
                            height: 36,
                            child: logoPath == null
                                ? Icon(
                                    Icons.cloud_download_outlined,
                                    color: AppColors.primary900,
                                    size: 22,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ColoredBox(
                                          color: ImportEmrAssets
                                              .tileBackdropForSource(src),
                                        ),
                                        Image.asset(
                                          logoPath,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, _, _) => Icon(
                                            Icons.image_not_supported_outlined,
                                            color: AppColors.primary900
                                                .withValues(alpha: 0.5),
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Nhập dữ liệu từ $label thành công!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary900,
              ),
            ),
          ],
        ),
        footer: EverwellPrimaryButton(
          label: 'Tiếp tục',
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
    );
  }
}
