import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/app_scope.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/import_emr_assets.dart';
import '../../../../core/presentation/widgets/everwell_auth_panel_layout.dart';
import '../../../../core/presentation/widgets/everwell_auth_scaffold.dart';
import '../../../../core/presentation/widgets/everwell_primary_button.dart';

// Figma node-id: 806:4719 — Login: Import EMRs (WS-A A11)
class ImportEmrPage extends StatelessWidget {
  const ImportEmrPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> pick(String source) async {
      try {
        await AppScope.onboardingRepository.importFrom(source);
        if (!context.mounted) return;
        context.push(AppRoutes.onboardingImportEmrSuccess);
      } catch (_) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Nhập thất bại (mock).')));
      }
    }

    return EverwellAuthScaffold(
      maxPanelHeightFraction: 0.78,
      panel: EverwellAuthPanelLayout(
        header: const EverwellAuthPanelTitle('NHẬP DỮ LIỆU BỆNH ÁN'),
        headerSpacingAfter: 16,
        scrollable: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ImportTile(
              leadingBackground: const Color(0xFFEB0000),
              logoAsset: ImportEmrAssets.vneidTile,
              title: 'Nhập từ VNEID',
              onTap: () => pick('VNEID'),
            ),
            const SizedBox(height: 10),
            _ImportTile(
              leadingBackground: Colors.white,
              logoAsset: ImportEmrAssets.govTile,
              title: 'Nhập từ GOV',
              onTap: () => pick('GOV'),
            ),
            const SizedBox(height: 10),
            _ImportTile(
              leadingBackground: Colors.white,
              logoAsset: ImportEmrAssets.choRayTile,
              title: 'Nhập từ CHO RAY',
              onTap: () => pick('CHO_RAY'),
            ),
          ],
        ),
        footer: EverwellPrimaryButton(
          label: 'Bỏ qua',
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
    );
  }
}

class _ImportTile extends StatelessWidget {
  const _ImportTile({
    required this.leadingBackground,
    required this.logoAsset,
    required this.title,
    required this.onTap,
  });

  final Color leadingBackground;
  final String logoAsset;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary50,
      borderRadius: BorderRadius.circular(15),
      elevation: 2,
      shadowColor: Colors.black26,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ColoredBox(color: leadingBackground),
                      Image.asset(
                        logoAsset,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.primary900.withValues(alpha: 0.5),
                            size: 24,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
