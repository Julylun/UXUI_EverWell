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
import '../../domain/models/medical_record_detail.dart';
import '../view_models/medical_record_detail_view_model.dart';

// Figma node-id: 806:10716 — Chi tiết hồ sơ (WS-C C2)
class MedicalRecordDetailPage extends StatefulWidget {
  const MedicalRecordDetailPage({super.key, required this.recordId});

  final String recordId;

  @override
  State<MedicalRecordDetailPage> createState() =>
      _MedicalRecordDetailPageState();
}

class _MedicalRecordDetailPageState extends State<MedicalRecordDetailPage> {
  late final MedicalRecordDetailViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = MedicalRecordDetailViewModel(
      MedicalRecordsRepository(const MockMedicalRecordsService()),
      widget.recordId,
    );
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
      appBar: const EverwellRecordsAppBar(
        title: 'Chi Tiết Hồ Sơ',
        headerCircleAsset: EverwellFigmaMcpRasterAssets.mrC2HeaderCircle,
        backArrowAsset: EverwellFigmaMcpRasterAssets.mrC2BackArrow,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListenableBuilder(
              listenable: _vm,
              builder: (context, _) {
                if (_vm.isLoading && _vm.detail == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_vm.error != null || _vm.detail == null) {
                  return Center(
                    child: Text(
                      _vm.error ?? 'Không có dữ liệu',
                      style: EverwellFigmaText.quicksandRegular(
                        15,
                        color: FigmaTokens.gray585858,
                      ),
                    ),
                  );
                }
                final d = _vm.detail!;
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  children: [
                    _diagnosisHeroCard(d),
                    const SizedBox(height: 16),
                    _doctorFacilityTile(
                      iconBg: FigmaTokens.overlayBlue10,
                      iconAsset: EverwellFigmaMcpRasterAssets.mrC2TileDoctor,
                      iconSize: const Size(20, 20),
                      label: d.doctorLabel,
                      value: d.doctorName,
                    ),
                    const SizedBox(height: 16),
                    _doctorFacilityTile(
                      iconBg: FigmaTokens.overlayGreen10,
                      iconAsset: EverwellFigmaMcpRasterAssets.mrC2TileHospital,
                      iconSize: const Size(18, 18),
                      label: d.facilityLabel,
                      value: d.facilityName,
                    ),
                    const SizedBox(height: 16),
                    _diagnosisOrdersCard(d),
                    const SizedBox(height: 16),
                    _attachmentsIntro(context, d),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary900,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đơn thuốc — WS-D')),
                          );
                        },
                        child: Text(
                          'Xem đơn thuốc',
                          style: EverwellFigmaText.interSemi(16, color: AppColors.white)
                              .copyWith(height: 24 / 16),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const EverwellBottomTabBar(
            activeIndex: 2,
            tabAssets: EverwellTabMcpAssets.medicalDetail,
          ),
        ],
      ),
    );
  }

  static Widget _diagnosisHeroCard(MedicalRecordDetail d) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0061A4),
            blurRadius: 32,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                d.mainDiagnosisCaption,
                style: EverwellFigmaText.interMedium(16, color: FigmaTokens.grayA7),
              ),
              const SizedBox(height: 8),
              Text(
                d.mainDiagnosisTitle,
                style: EverwellFigmaText.interBold(16, color: FigmaTokens.gray585858),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Image.asset(
                    EverwellFigmaMcpRasterAssets.mrC2DateSmall,
                    width: 11,
                    height: 12,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    d.visitDateLong,
                    style: EverwellFigmaText.quicksandSemi(14, color: FigmaTokens.grayA7),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary100,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                d.specialtyPill,
                style: EverwellFigmaText.interBold(13, color: FigmaTokens.gray585858),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _doctorFacilityTile({
    required Color iconBg,
    required String iconAsset,
    required Size iconSize,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x050061A4),
            blurRadius: 32,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: EverwellFigmaText.interBold(11, color: FigmaTokens.grayA7),
                ),
                Text(
                  value,
                  style: EverwellFigmaText.interBold(16, color: FigmaTokens.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _diagnosisOrdersCard(MedicalRecordDetail d) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0061A4),
            blurRadius: 32,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                EverwellFigmaMcpRasterAssets.mrC2SectionClipboard,
                width: 16,
                height: 20,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.medium,
              ),
              const SizedBox(width: 8),
              Text(
                d.diagnosisSectionTitle,
                style: EverwellFigmaText.interBold(16, color: FigmaTokens.black),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  d.diagnosisDetailCaption,
                  style: EverwellFigmaText.quicksandMedium(12, color: AppColors.primary900),
                ),
                const SizedBox(height: 8),
                Text(
                  d.diagnosisParagraph,
                  style: EverwellFigmaText.quicksandSemi(14, color: FigmaTokens.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: const Border(
                left: BorderSide(color: AppColors.primary800, width: 4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  d.adviceTitle,
                  style: EverwellFigmaText.quicksandMedium(12, color: AppColors.primary900),
                ),
                const SizedBox(height: 8),
                ...d.adviceBullets.map<Widget>(
                  (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '•',
                          style: EverwellFigmaText.interSemi(14, color: AppColors.primary800),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            b,
                            style: EverwellFigmaText.quicksandSemi(
                              14,
                              color: FigmaTokens.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _attachmentsIntro(BuildContext context, MedicalRecordDetail d) {
    if (d.primaryAttachmentTitle.isEmpty) {
      return const SizedBox.shrink();
    }
    return Material(
      color: AppColors.primary50,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push(
          AppRoutes.medicalRecordAttachments(d.id),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    EverwellFigmaMcpRasterAssets.mrC2AttachmentPdf,
                    width: 20,
                    height: 13,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    d.attachmentsSectionTitle,
                    style: EverwellFigmaText.quicksandSemi(18, color: FigmaTokens.black),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: FigmaTokens.error100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Image.asset(
                          EverwellFigmaMcpRasterAssets.mrC2AttachmentChevron,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.primaryAttachmentTitle,
                            style: EverwellFigmaText.quicksandSemi(
                              14,
                              color: FigmaTokens.black,
                            ),
                          ),
                          Text(
                            d.primaryAttachmentSubtitle,
                            style: EverwellFigmaText.interRegular(
                              11,
                              color: FigmaTokens.grayA7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      EverwellFigmaMcpRasterAssets.mrC2AttachmentOpen,
                      width: 16,
                      height: 16,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.medium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
