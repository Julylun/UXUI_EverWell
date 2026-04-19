import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/everwell_figma_mcp_raster_assets.dart';
import '../../../../core/presentation/theme/everwell_figma_text.dart';
import '../../../../core/presentation/theme/figma_tokens.dart';
import '../../domain/models/medical_record_filter.dart';

/// Bottom sheet C3 — Figma MCP `806:10811`.
Future<MedicalRecordFilter?> showMedicalRecordFilterSheet(
  BuildContext context, {
  MedicalRecordFilter? initial,
}) {
  return showModalBottomSheet<MedicalRecordFilter>(
    context: context,
    isScrollControlled: true,
    barrierColor: FigmaTokens.scrim40,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _MedicalRecordFilterSheetBody(initial: initial),
  );
}

class _MedicalRecordFilterSheetBody extends StatefulWidget {
  const _MedicalRecordFilterSheetBody({this.initial});

  final MedicalRecordFilter? initial;

  @override
  State<_MedicalRecordFilterSheetBody> createState() =>
      _MedicalRecordFilterSheetBodyState();
}

class _MedicalRecordFilterSheetBodyState
    extends State<_MedicalRecordFilterSheetBody> {
  late String _timeChoice;
  late String _specialtyChoice;

  static const _timeOptions = ['Tất cả', '30 ngày', '90 ngày'];
  static const _specOptions = [
    'Tất cả',
    'Nội Khoa',
    'Tim mạch',
    'Tiêu hóa',
  ];

  @override
  void initState() {
    super.initState();
    _timeChoice = 'Tất cả';
    final sk = widget.initial?.specialtyKeyword?.trim();
    _specialtyChoice = (sk == null || sk.isEmpty)
        ? 'Tất cả'
        : _specOptions.firstWhere(
            (o) => o.toLowerCase().contains(sk.toLowerCase()),
            orElse: () => 'Tất cả',
          );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Color(0x1F0061A4),
                offset: Offset(0, -8),
                blurRadius: 32,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: FigmaTokens.borderD9,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 8, 8),
                child: Row(
                  children: [
                    Text(
                      'Bộ lọc',
                      style: EverwellFigmaText.manropeBold(
                        20,
                        color: FigmaTokens.black,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                      icon: Image.asset(
                        EverwellFigmaMcpRasterAssets.mrC3SheetClose,
                        width: 14,
                        height: 14,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                  children: [
                    _sectionLabel('THỜI GIAN'),
                    const SizedBox(height: 12.5),
                    _dropdownField(
                      value: _timeChoice,
                      items: _timeOptions,
                      onChanged: (v) => setState(() => _timeChoice = v!),
                    ),
                    const SizedBox(height: 32),
                    _sectionLabel('CHUYÊN KHOA'),
                    const SizedBox(height: 12.5),
                    _dropdownField(
                      value: _specialtyChoice,
                      items: _specOptions,
                      onChanged: (v) => setState(() => _specialtyChoice = v!),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MedicalRecordFilter(
                          hospitalKeyword:
                              widget.initial?.hospitalKeyword,
                          specialtyKeyword: _specialtyChoice == 'Tất cả'
                              ? null
                              : _specialtyChoice,
                        ),
                      );
                    },
                    child: Text(
                      'Áp dụng bộ lọc',
                      style: EverwellFigmaText.interSemi(
                        15,
                        color: AppColors.primary900,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary900,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pop(context, const MedicalRecordFilter());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          EverwellFigmaMcpRasterAssets.mrC3ClearFilterTrash,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Xóa bộ lọc',
                          style: EverwellFigmaText.interSemi(
                            18,
                            color: AppColors.white,
                          ).copyWith(height: 28 / 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _sectionLabel(String text) {
    return Text(
      text,
      style: EverwellFigmaText.interSemi(
        14,
        color: FigmaTokens.gray373737,
      ).copyWith(letterSpacing: 0.7),
    );
  }

  Widget _dropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: FigmaTokens.borderD9.withValues(alpha: 0.35)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: Image.asset(
            EverwellFigmaMcpRasterAssets.mrC3DropdownChevron,
            width: 12,
            height: 7,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
          ),
          style: EverwellFigmaText.interMedium(16, color: FigmaTokens.black),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
