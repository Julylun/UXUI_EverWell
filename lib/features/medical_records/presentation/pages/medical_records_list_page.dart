import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/everwell_figma_mcp_raster_assets.dart';
import '../../../../core/presentation/theme/everwell_figma_text.dart';
import '../../../../core/presentation/theme/figma_tokens.dart';
import '../../../../core/presentation/widgets/everwell_bottom_tab_bar.dart';
import '../../../../core/presentation/widgets/everwell_records_app_bar.dart';
import '../../data/repositories/medical_records_repository.dart';
import '../../data/services/mock_medical_records_service.dart';
import '../../domain/models/medical_record_filter.dart';
import '../view_models/medical_records_list_view_model.dart';
import '../widgets/medical_record_filter_sheet.dart';
import '../widgets/medical_record_row_tile.dart';

// Figma node-id: 806:10937 — Hồ sơ khám bệnh (WS-C C1)
class MedicalRecordsListPage extends StatefulWidget {
  const MedicalRecordsListPage({super.key});

  @override
  State<MedicalRecordsListPage> createState() => _MedicalRecordsListPageState();
}

class _MedicalRecordsListPageState extends State<MedicalRecordsListPage> {
  late final MedicalRecordsListViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = MedicalRecordsListViewModel(
      MedicalRecordsRepository(const MockMedicalRecordsService()),
    );
    _vm.load();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  Future<void> _openFilter() async {
    final result = await showMedicalRecordFilterSheet(
      context,
      initial: _vm.activeFilter,
    );
    if (!mounted || result == null) return;
    _vm.setFilter(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const EverwellRecordsAppBar(title: 'Hồ sơ khám bệnh'),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: ListenableBuilder(
                  listenable: _vm,
                  builder: (context, _) {
                    if (_vm.isLoading && _vm.records.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (_vm.error != null && _vm.records.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            _vm.error!,
                            textAlign: TextAlign.center,
                            style: EverwellFigmaText.quicksandRegular(
                              15,
                              color: FigmaTokens.gray585858,
                            ),
                          ),
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () => _vm.load(forceRefresh: true),
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                            sliver: SliverToBoxAdapter(
                              child: _SearchBar(onFilterTap: _openFilter),
                            ),
                          ),
                          if (!_vm.activeFilter.isEmpty)
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                              sliver: SliverToBoxAdapter(
                                child: Text(
                                  _filterSummaryLine(_vm.activeFilter),
                                  style: EverwellFigmaText.interSemi(
                                    13,
                                    color: AppColors.primary800,
                                  ),
                                ),
                              ),
                            ),
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, i) {
                                  final r = _vm.records[i];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: i < _vm.records.length - 1
                                          ? 16
                                          : 0,
                                    ),
                                    child: MedicalRecordRowTile(
                                      record: r,
                                      onTap: () => context.push(
                                        AppRoutes.medicalRecordDetail(r.id),
                                      ),
                                    ),
                                  );
                                },
                                childCount: _vm.records.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const EverwellBottomTabBar(
                activeIndex: 2,
                tabAssets: EverwellTabMcpAssets.medicalList,
              ),
            ],
          ),
          Positioned(
            right: 24,
            bottom: 112,
            child: Material(
              color: AppColors.primary900,
              borderRadius: BorderRadius.circular(16),
              elevation: 8,
              shadowColor: const Color(0x4D0061A4),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thêm hồ sơ — mock')),
                  );
                },
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: Center(
                    child: Image.asset(
                      EverwellFigmaMcpRasterAssets.mrC1FabPlus,
                      width: 19,
                      height: 19,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _filterSummaryLine(MedicalRecordFilter f) {
    final parts = <String>[];
    final h = f.hospitalKeyword?.trim();
    final s = f.specialtyKeyword?.trim();
    if (h != null && h.isNotEmpty) parts.add('BV “$h”');
    if (s != null && s.isNotEmpty) parts.add('Chuyên khoa “$s”');
    return 'Đang lọc: ${parts.join(' · ')}';
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onFilterTap});

  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(
            EverwellFigmaMcpRasterAssets.mrC1SearchMagnifier,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tìm kiếm...',
              style: EverwellFigmaText.quicksandRegular(
                16,
                color: FigmaTokens.black,
              ),
            ),
          ),
          IconButton(
            onPressed: onFilterTap,
            icon: Image.asset(
              EverwellFigmaMcpRasterAssets.mrC1SearchFilter,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.medium,
            ),
          ),
        ],
      ),
    );
  }
}
