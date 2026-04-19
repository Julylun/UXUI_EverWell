import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/everwell_figma_mcp_raster_assets.dart';
import '../../../../core/presentation/theme/everwell_figma_text.dart';
import '../../../../core/presentation/theme/figma_tokens.dart';
import '../../../../core/presentation/widgets/everwell_bottom_tab_bar.dart';
import '../../../../core/presentation/widgets/everwell_records_app_bar.dart';
import '../../data/repositories/medical_records_repository.dart';
import '../../data/services/mock_medical_records_service.dart';
import '../../domain/models/attachment_item.dart';
import '../../domain/models/medical_record_detail.dart';
import '../view_models/medical_record_detail_view_model.dart';

// Figma node-id: 806:10601 — Tài liệu đính kèm (WS-C C4)
class MedicalRecordAttachmentsPage extends StatefulWidget {
  const MedicalRecordAttachmentsPage({super.key, required this.recordId});

  final String recordId;

  @override
  State<MedicalRecordAttachmentsPage> createState() =>
      _MedicalRecordAttachmentsPageState();
}

class _MedicalRecordAttachmentsPageState
    extends State<MedicalRecordAttachmentsPage> {
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
        title: 'Tài Liệu Đính Kèm',
        headerCircleAsset: EverwellFigmaMcpRasterAssets.mrC4HeaderCircle,
        backArrowAsset: EverwellFigmaMcpRasterAssets.mrC4BackArrow,
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
                final d = _vm.detail;
                if (d == null || d.attachments.isEmpty) {
                  return Center(
                    child: Text(
                      'Không có tài liệu',
                      style: EverwellFigmaText.quicksandSemi(
                        16,
                        color: FigmaTokens.gray585858,
                      ),
                    ),
                  );
                }
                final first = d.attachments.first;
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  children: [
                    _titleCard(d, first),
                    const SizedBox(height: 24),
                    _previewSkeleton(),
                    const SizedBox(height: 24),
                    _downloadCard(),
                    const SizedBox(height: 16),
                    _metaCard(first),
                    const SizedBox(height: 26),
                    _relatedHeader(),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 148,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _relatedMini(
                            'Đơn thuốc ngoại trú',
                            '20/10/2023',
                            EverwellFigmaMcpRasterAssets.mrC4RelatedRx,
                          ),
                          const SizedBox(width: 16),
                          _relatedMini(
                            'Ảnh chụp X-Quang phổi',
                            '15/10/2023',
                            EverwellFigmaMcpRasterAssets.mrC4RelatedXray,
                            iconBg: const Color(0x1A42A547),
                            iconSize: const Size(18, 18),
                          ),
                          const SizedBox(width: 16),
                          _relatedMini(
                            'Báo cáo tổng hợp quý',
                            '01/10/2023',
                            EverwellFigmaMcpRasterAssets.mrC4RelatedReport,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const EverwellBottomTabBar(
            activeIndex: 2,
            tabAssets: EverwellTabMcpAssets.medicalAttachments,
          ),
        ],
      ),
    );
  }

  Widget _titleCard(MedicalRecordDetail d, AttachmentItem first) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            EverwellFigmaMcpRasterAssets.mrC4TitlePdfIcon,
            width: 40,
            height: 44,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${first.title} -\n25/10/2023',
                  style: EverwellFigmaText.quicksandSemi(18, color: FigmaTokens.black),
                ),
                const SizedBox(height: 4),
                Text(
                  d.facilityName,
                  style: EverwellFigmaText.quicksandSemi(14, color: FigmaTokens.gray373737),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _chip('Nội khoa', AppColors.primary50, FigmaTokens.gray585858),
                    _chip('Đã xác nhận', FigmaTokens.success300, FigmaTokens.black),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: EverwellFigmaText.quicksandMedium(12, color: fg),
      ),
    );
  }

  Widget _previewSkeleton() {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(color: AppColors.primary50),
              Positioned(
                left: 32,
                right: 32,
                top: 32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 128,
                          height: 32,
                          decoration: BoxDecoration(
                            color: FigmaTokens.overlayBlue10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Container(
                          width: 96,
                          height: 16,
                          decoration: BoxDecoration(
                            color: FigmaTokens.borderD9,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 24,
                      width: 220,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Container(
                        width: 192,
                        height: 192,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: FigmaTokens.grayA7, width: 2),
                        ),
                        child: Image.asset(
                          EverwellFigmaMcpRasterAssets.mrC4PreviewImage,
                          width: 33,
                          height: 21,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16,
                bottom: 24,
                child: Column(
                  children: [
                    _zoomFab(EverwellFigmaMcpRasterAssets.mrC4ZoomIn),
                    const SizedBox(height: 12),
                    _zoomFab(EverwellFigmaMcpRasterAssets.mrC4ZoomOut),
                    const SizedBox(height: 12),
                    _zoomFab(EverwellFigmaMcpRasterAssets.mrC4ZoomReset),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _zoomFab(String asset) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.95),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(
        asset,
        width: 18,
        height: 18,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.medium,
      ),
    );
  }

  Widget _downloadCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thao tác tài liệu',
            style: EverwellFigmaText.interBold(16, color: FigmaTokens.black),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary900,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                shadowColor: const Color(0x1F0061A4),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    EverwellFigmaMcpRasterAssets.mrC4Download,
                    width: 16,
                    height: 16,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Tải xuống',
                    style: EverwellFigmaText.interBold(16, color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaCard(AttachmentItem first) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x1ABFC7D4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'THÔNG TIN BỔ SUNG',
            style: EverwellFigmaText.interBold(13, color: FigmaTokens.grayA7),
          ),
          const SizedBox(height: 16),
          _metaRow('Kích thước', '1.2 MB'),
          _metaRow('Định dạng', 'PDF'),
          _metaRow('Người ký', 'BS. Lê Văn A', valueColor: AppColors.primary800),
        ],
      ),
    );
  }

  static Widget _metaRow(String k, String v, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            k,
            style: EverwellFigmaText.quicksandSemi(14, color: FigmaTokens.gray373737),
          ),
          Text(
            v,
            style: EverwellFigmaText.quicksandSemi(
              14,
              color: valueColor ?? FigmaTokens.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _relatedHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tài liệu liên quan',
          style: EverwellFigmaText.quicksandSemi(20, color: FigmaTokens.black),
        ),
        Text(
          'Xem tất cả',
          style: EverwellFigmaText.quicksandSemi(14, color: AppColors.primary800),
        ),
      ],
    );
  }

  Widget _relatedMini(
    String title,
    String date,
    String iconAsset, {
    Color? iconBg,
    Size iconSize = const Size(20, 20),
  }) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg ?? AppColors.primary50,
              borderRadius: BorderRadius.circular(8),
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
          const SizedBox(height: 8),
          Text(
            title,
            style: EverwellFigmaText.quicksandSemi(14, color: FigmaTokens.black),
          ),
          Text(
            date,
            style: EverwellFigmaText.quicksandMedium(12, color: FigmaTokens.gray373737),
          ),
        ],
      ),
    );
  }
}
