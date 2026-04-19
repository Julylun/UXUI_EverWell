import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/everwell_figma_mcp_raster_assets.dart';
import '../../../../core/presentation/theme/everwell_figma_text.dart';
import '../../../../core/presentation/theme/figma_tokens.dart';
import '../../domain/models/medical_record_summary.dart';

/// Thẻ hồ sơ C1 — Figma `806:10937`.
class MedicalRecordRowTile extends StatelessWidget {
  const MedicalRecordRowTile({
    super.key,
    required this.record,
    required this.onTap,
  });

  final MedicalRecordSummary record;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary50,
      borderRadius: BorderRadius.circular(12),
      elevation: 0,
      shadowColor: const Color(0x0A0061A4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A0061A4),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.titleLine1,
                          style: EverwellFigmaText.quicksandSemi(
                            18,
                            color: FigmaTokens.black,
                          ),
                        ),
                        Text(
                          record.titleLine2,
                          style: EverwellFigmaText.quicksandSemi(
                            18,
                            color: FigmaTokens.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary100,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      record.departmentPill,
                      style: EverwellFigmaText.interBold(
                        11,
                        color: FigmaTokens.gray585858,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _row(EverwellFigmaMcpRasterAssets.mrC1RowCalendar, record.dateLong),
              const SizedBox(height: 10),
              _row(EverwellFigmaMcpRasterAssets.mrC1RowDoctor, record.doctorName),
              const SizedBox(height: 10),
              _row(EverwellFigmaMcpRasterAssets.mrC1RowHospital, record.hospital),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          EverwellFigmaMcpRasterAssets.mrC1RowClip,
                          width: 10,
                          height: 13,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          record.attachmentLabel,
                          style: EverwellFigmaText.quicksandMedium(
                            12,
                            color: AppColors.primary800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    EverwellFigmaMcpRasterAssets.mrC1RowChevron,
                    width: 7,
                    height: 12,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _row(String iconAsset, String text) {
    return Row(
      children: [
        SizedBox(
          width: 15,
          height: 15,
          child: Image.asset(
            iconAsset,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: EverwellFigmaText.interRegular(13, color: FigmaTokens.black),
          ),
        ),
      ],
    );
  }
}
