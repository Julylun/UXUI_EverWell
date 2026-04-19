import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/everwell_figma_mcp_raster_assets.dart';
import '../../../../core/presentation/theme/everwell_figma_text.dart';
import '../../../../core/presentation/theme/figma_tokens.dart';
import '../../../../core/presentation/widgets/everwell_bottom_tab_bar.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/services/mock_home_service.dart';
import '../../domain/models/home_dashboard.dart';
import '../view_models/home_view_model.dart';

// Figma node-id: 806:11044 — Trang chủ (WS-B B1), MCP `get_design_context`.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = HomeViewModel(HomeRepository(const MockHomeService()));
    _vm.load();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _vm.load(forceRefresh: true),
                child: ListenableBuilder(
                  listenable: _vm,
                  builder: (context, _) {
                    if (_vm.isLoading && _vm.dashboard == null) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 120),
                          Center(child: CircularProgressIndicator()),
                        ],
                      );
                    }
                    if (_vm.error != null && _vm.dashboard == null) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(24),
                        children: [
                          Text(
                            _vm.error!,
                            style: EverwellFigmaText.quicksandRegular(
                              15,
                              color: FigmaTokens.gray585858,
                            ),
                          ),
                        ],
                      );
                    }
                    final d = _vm.dashboard!;
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                      children: [
                        Text(
                          d.greetingHeadline,
                          style: EverwellFigmaText.quicksandSemi(
                            40,
                            color: FigmaTokens.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          d.dateLine,
                          style: EverwellFigmaText.quicksandSemi(
                            18,
                            color: FigmaTokens.gray585858,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _MedicationAlertCard(
                          d,
                          onTap: () => context.push(
                            AppRoutes.medicationReminderSchedule,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _QuickAccessSection(
                          onMedical: () =>
                              context.push(AppRoutes.medicalRecordsList),
                          onPrescription: () =>
                              context.push(AppRoutes.medicationPrescriptions),
                          onCabinet: () =>
                              context.push(AppRoutes.medicationCabinet),
                          onReminder: () => context.push(
                            AppRoutes.medicationReminderSchedule,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _MedicationScheduleEmpty(
                          onAddPrescription: () =>
                              context.push(AppRoutes.medicationAddPrescription),
                        ),
                        const SizedBox(height: 32),
                        _RecentRecordCard(
                          visit: d.recentPreview,
                          onTap: () => context.push(
                            AppRoutes.medicalRecordDetail(
                              d.recentPreview.recordId,
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    );
                  },
                ),
              ),
            ),
            EverwellBottomTabBar(
              activeIndex: 2,
              tabAssets: EverwellTabMcpAssets.homeScreen,
              onHome: () => context.push(AppRoutes.healthHeartInput),
              onProfile: () => context.push(AppRoutes.medicalRecordsList),
              onSettings: () => context.push(AppRoutes.medicationCabinet),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicationAlertCard extends StatelessWidget {
  const _MedicationAlertCard(this.d, {required this.onTap});

  final HomeDashboard d;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary100,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: FigmaTokens.warning500,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    EverwellFigmaMcpRasterAssets.homeAlertBell,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d.alertTitleLine1,
                      style: EverwellFigmaText.quicksandSemi(
                        18,
                        color: FigmaTokens.black,
                      ),
                    ),
                    Text(
                      d.alertTitleLine2,
                      style: EverwellFigmaText.quicksandSemi(
                        18,
                        color: FigmaTokens.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      d.alertSubtitleLine1,
                      style: EverwellFigmaText.quicksandRegular(
                        14,
                        color: FigmaTokens.black,
                      ),
                    ),
                    Text(
                      d.alertSubtitleLine2,
                      style: EverwellFigmaText.quicksandRegular(
                        14,
                        color: FigmaTokens.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SizedBox(
                  width: 12,
                  height: 16,
                  child: Image.asset(
                    EverwellFigmaMcpRasterAssets.homeChevronRight,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
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

class _QuickAccessSection extends StatelessWidget {
  const _QuickAccessSection({
    required this.onMedical,
    required this.onPrescription,
    required this.onCabinet,
    required this.onReminder,
  });

  final VoidCallback onMedical;
  final VoidCallback onPrescription;
  final VoidCallback onCabinet;
  final VoidCallback onReminder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Truy cập nhanh',
            style: EverwellFigmaText.quicksandSemi(
              20,
              color: FigmaTokens.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.05,
          children: [
            _BentoTile(
              bgIcon: AppColors.primary700,
              iconAsset: EverwellFigmaMcpRasterAssets.homeBentoMedicalRecords,
              iconSize: const Size(16, 20),
              label: 'Hồ sơ khám',
              labelColor: AppColors.primary700,
              onTap: onMedical,
            ),
            _BentoTile(
              bgIcon: FigmaTokens.success800,
              iconAsset: EverwellFigmaMcpRasterAssets.homeBentoPrescriptions,
              iconSize: const Size(18, 18),
              label: 'Đơn thuốc',
              labelColor: FigmaTokens.success800,
              onTap: onPrescription,
            ),
            _BentoTile(
              bgIcon: FigmaTokens.purpleCabinet,
              iconAsset: EverwellFigmaMcpRasterAssets.homeBentoMedicineCabinet,
              iconSize: const Size(14, 18),
              label: 'Tủ thuốc',
              labelColor: FigmaTokens.purpleCabinet,
              onTap: onCabinet,
              compactLabel: true,
            ),
            _BentoTile(
              bgIcon: FigmaTokens.redReminder,
              iconAsset: EverwellFigmaMcpRasterAssets.homeBentoReminders,
              iconSize: const Size(21, 20),
              label: 'Nhắc nhở',
              labelColor: FigmaTokens.redReminder,
              onTap: onReminder,
            ),
          ],
        ),
      ],
    );
  }
}

class _BentoTile extends StatelessWidget {
  const _BentoTile({
    required this.bgIcon,
    required this.iconAsset,
    required this.iconSize,
    required this.label,
    required this.labelColor,
    required this.onTap,
    this.compactLabel = false,
  });

  final Color bgIcon;
  final String iconAsset;
  final Size iconSize;
  final String label;
  final Color labelColor;
  final VoidCallback onTap;
  final bool compactLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary100,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: bgIcon,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: bgIcon.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    iconAsset,
                    width: iconSize.width,
                    height: iconSize.height,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                label,
                textAlign: TextAlign.center,
                style: compactLabel
                    ? EverwellFigmaText.interSemi(
                        16,
                        color: labelColor,
                      ).copyWith(height: 24 / 16)
                    : EverwellFigmaText.quicksandSemi(18, color: labelColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MedicationScheduleEmpty extends StatelessWidget {
  const _MedicationScheduleEmpty({required this.onAddPrescription});

  final VoidCallback onAddPrescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lịch uống thuốc hôm nay',
                style: EverwellFigmaText.quicksandSemi(
                  20,
                  color: FigmaTokens.black,
                ),
              ),
              Text(
                'Xem tất cả',
                style: EverwellFigmaText.quicksandSemi(
                  14,
                  color: AppColors.primary900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: FigmaTokens.borderD9),
          ),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: FigmaTokens.borderD9,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    EverwellFigmaMcpRasterAssets.homeScheduleEmptyCalendar,
                    width: 26,
                    height: 29,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Bạn không có lịch uống thuốc nào',
                textAlign: TextAlign.center,
                style: EverwellFigmaText.quicksandSemi(
                  18,
                  color: FigmaTokens.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Thêm đơn thuốc mới để nhận nhắc nhở\nmỗi ngày.',
                textAlign: TextAlign.center,
                style: EverwellFigmaText.quicksandSemi(
                  14,
                  color: FigmaTokens.gray585858,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary900,
                    foregroundColor: AppColors.primary50,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 32,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onAddPrescription,
                  child: Text(
                    'Thêm đơn thuốc',
                    style: EverwellFigmaText.interSemi(
                      16,
                      color: AppColors.primary50,
                    ).copyWith(height: 24 / 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RecentRecordCard extends StatelessWidget {
  const _RecentRecordCard({required this.visit, required this.onTap});

  final HomeRecentVisit visit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Hồ sơ gần đây',
            style: EverwellFigmaText.quicksandSemi(
              18,
              color: FigmaTokens.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shadowColor: const Color(0x0A0061A4),
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A0061A4),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primary100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Image.asset(
                          EverwellFigmaMcpRasterAssets.homeRecentVisitBag,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visit.titleLine1,
                            style: EverwellFigmaText.interBold(
                              16,
                              color: FigmaTokens.black,
                            ),
                          ),
                          Text(
                            visit.titleLine2,
                            style: EverwellFigmaText.interBold(
                              16,
                              color: FigmaTokens.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            visit.hospitalLine1,
                            style: EverwellFigmaText.quicksandSemi(
                              14,
                              color: AppColors.darkGray600,
                            ),
                          ),
                          Text(
                            visit.hospitalLine2,
                            style: EverwellFigmaText.quicksandSemi(
                              14,
                              color: AppColors.darkGray600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          visit.dateShort,
                          style: EverwellFigmaText.interBold(
                            11,
                            color: AppColors.darkGray600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: FigmaTokens.success400,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            visit.statusLabel,
                            style: EverwellFigmaText.interBold(
                              11,
                              color: AppColors.darkGray600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
