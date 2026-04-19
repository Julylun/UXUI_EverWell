import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/everwell_figma_mcp_raster_assets.dart';
import '../../data/repositories/medication_repository.dart';
import '../../data/services/mock_medication_service.dart';
import '../view_models/cabinet_flow_view_model.dart';
import '../view_models/prescription_flow_view_model.dart';
import '../view_models/reminder_flow_view_model.dart';
import '../widgets/medication_page_scaffold.dart';

MedicationRepository _repo() => MedicationRepository(const MockMedicationService());

class PrescriptionListPage extends StatefulWidget {
  const PrescriptionListPage({super.key});
  @override
  State<PrescriptionListPage> createState() => _PrescriptionListPageState();
}

class _PrescriptionListPageState extends State<PrescriptionListPage> {
  late final PrescriptionFlowViewModel vm;
  @override
  void initState() {
    super.initState();
    vm = PrescriptionFlowViewModel(_repo())..load();
  }

  @override
  Widget build(BuildContext context) {
    return MedicationPageScaffold(
      title: 'Đơn thuốc',
      fab: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.medicationAddPrescription),
        backgroundColor: const Color(0xFF1F4D73),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Image.asset(EverwellFigmaMcpRasterAssets.medFabPlus, width: 18, height: 18),
      ),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, _) {
          final list = vm.active;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
            children: [
              _MedicationSearchField(onTapFilter: () {}),
              const SizedBox(height: 16),
              Row(
                children: [
                  _PillTab(
                    text: 'Đang dùng (${list.length})',
                    active: true,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _PillTab(
                    text: 'Đã kết thúc (${vm.completed.length})',
                    active: false,
                    onTap: () => context.push(AppRoutes.medicationPrescriptionsCompleted),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...list.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _PrescriptionCard(
                    item: item,
                    statusColor: const Color(0xFF166534),
                    statusBackground: const Color(0x1A42A547),
                    statusText: 'ĐANG DÙNG',
                    moreTagColor: const Color(0x4DCFE6F2),
                    onTap: () => context.push(AppRoutes.medicationPrescriptionDetail),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: const [
                  Expanded(
                    child: _StatsCard(
                      iconAsset: EverwellFigmaMcpRasterAssets.medStatsCalendar,
                      iconWidth: 25,
                      iconHeight: 25,
                      title: 'Lần khám tiếp theo',
                      value: '05 Th6, 2024',
                      background: Color(0xFFECF7FF),
                      titleColor: Color(0xB30061A4),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _StatsCard(
                      iconAsset: EverwellFigmaMcpRasterAssets.medStatsDone,
                      iconWidth: 32,
                      iconHeight: 25,
                      title: 'HOÀN THÀNH',
                      value: '12 đơn thuốc',
                      background: Color(0x3378DC77),
                      titleColor: Color(0xFF14532D),
                      boldTitle: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class PrescriptionCompletedPage extends StatefulWidget {
  const PrescriptionCompletedPage({super.key});
  @override
  State<PrescriptionCompletedPage> createState() => _PrescriptionCompletedPageState();
}

class _PrescriptionCompletedPageState extends State<PrescriptionCompletedPage> {
  late final PrescriptionFlowViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = PrescriptionFlowViewModel(_repo())..load();
  }

  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Đơn thuốc',
        fab: FloatingActionButton(
          onPressed: () => context.push(AppRoutes.medicationAddPrescription),
          backgroundColor: const Color(0xFF1F4D73),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Image.asset(EverwellFigmaMcpRasterAssets.medFabPlus, width: 18, height: 18),
        ),
        body: ListenableBuilder(
          listenable: vm,
          builder: (context, _) => ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
            children: [
              _MedicationSearchField(onTapFilter: () {}),
              const SizedBox(height: 16),
              Row(
                children: [
                  _PillTab(
                    text: 'Đang dùng (${vm.active.length})',
                    active: false,
                    onTap: () => context.pop(),
                  ),
                  const SizedBox(width: 8),
                  _PillTab(
                    text: 'Đã kết thúc (${vm.completed.length})',
                    active: true,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...vm.completed.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _PrescriptionCard(
                    item: item,
                    statusColor: Colors.white,
                    statusBackground: const Color(0xFFA7A7A7),
                    statusText: 'ĐÃ KẾT THÚC',
                    moreTagColor: const Color(0x4DCFE6F2),
                    moreTagTextColor: const Color(0xFFA7A7A7),
                    onTap: () => context.push(AppRoutes.medicationPrescriptionDetail),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: const [
                  Expanded(
                    child: _StatsCard(
                      iconAsset: EverwellFigmaMcpRasterAssets.medHealthTip,
                      iconWidth: 16,
                      iconHeight: 20,
                      title: 'Mẹo sức khỏe',
                      value: 'Uống nhiều nước ấm',
                      subtitle: 'để làm dịu cổ họng...',
                      background: Color(0x1A94F990),
                      titleColor: Colors.black,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _StatsCard(
                      iconAsset: EverwellFigmaMcpRasterAssets.medReminderIllustration,
                      iconWidth: 24,
                      iconHeight: 24,
                      title: 'Lịch nhắc',
                      value: 'Không có thuốc cần',
                      subtitle: 'uống hôm nay.',
                      background: Color(0x4DCFE6F2),
                      titleColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class PrescriptionDetailPage extends StatelessWidget {
  const PrescriptionDetailPage({super.key});
  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Chi Tiết Đơn Thuốc',
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 130),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFECF7FF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _StatusTag(text: 'ĐANG DÙNG'),
                            SizedBox(height: 6),
                            Text('Ngày kê đơn', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF373737))),
                            SizedBox(height: 4),
                            Text('Thứ Bảy, 28 tháng 3, 2026', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      _AssetIcon(EverwellFigmaMcpRasterAssets.medDetailSummaryIcon, size: 40),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(color: Color(0x4DE0E3E6), height: 1),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _AssetIcon(EverwellFigmaMcpRasterAssets.medDetailHistory, size: 14),
                      const SizedBox(width: 8),
                      const Text('Còn 12 ngày thuốc', style: TextStyle(color: Color(0xFF307AB5), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailSection(
              title: 'BÁC SĨ PHỤ TRÁCH',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(EverwellFigmaMcpRasterAssets.medDoctorAvatar, width: 56, height: 56, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('BS. Nguyễn Văn A', style: TextStyle(fontWeight: FontWeight.w700)),
                          Text('Bệnh viện Đa khoa Quốc tế', style: TextStyle(color: Color(0xFF373737))),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(color: Color(0x1A2196F3), shape: BoxShape.circle),
                      child: Center(child: _AssetIcon(EverwellFigmaMcpRasterAssets.medDetailCall, size: 18)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  const _AssetIcon(EverwellFigmaMcpRasterAssets.medDetailLinkRecord, size: 22),
                  const SizedBox(width: 10),
                  const Expanded(child: Text('Xem hồ sơ khám liên quan', style: TextStyle(fontWeight: FontWeight.w600))),
                  const _AssetIcon(EverwellFigmaMcpRasterAssets.medDetailChevron, size: 12),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailSection(
              title: 'CHỈ DẪN SỬ DỤNG',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(18)),
                child: Row(
                  children: [
                    const _AssetIcon(EverwellFigmaMcpRasterAssets.medDetailInfo, size: 20),
                    const SizedBox(width: 10),
                    const Expanded(child: Text('Uống thuốc sau ăn 30 phút. Không uống cùng sữa.', style: TextStyle(fontWeight: FontWeight.w600))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const _DetailSection(
              title: 'DANH MỤC THUỐC',
              child: Column(
                children: [
                  _MedicationDetailCard(
                    name: 'Omeprazole 20mg',
                    meta: 'Hộp 30 viên',
                    duration: '30 ngày',
                    frequency: '2 lần/ngày',
                    dosage: '1 viên / lần',
                    periods: ['Sáng', 'Tối'],
                    note: 'Ghi chú: Uống trước ăn 30 phút',
                  ),
                  SizedBox(height: 12),
                  _MedicationDetailCard(
                    name: 'Motilium 10mg',
                    meta: 'Vỉ 10 viên',
                    duration: '15 ngày',
                    frequency: '3 lần/ngày',
                    dosage: '1 viên / lần',
                    periods: ['Sáng', 'Trưa', 'Tối'],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.medicationCreateReminder),
              icon: const _AssetIcon(EverwellFigmaMcpRasterAssets.medCtaBell, size: 20),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F4D73),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              label: const Text('Tạo lịch nhắc nhở'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.medicationAddToCabinet),
              icon: const _AssetIcon(EverwellFigmaMcpRasterAssets.medCtaCabinet, size: 20),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD9D9D9),
                foregroundColor: const Color(0xFF373737),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                elevation: 0,
              ),
              label: const Text('Thêm vào tủ thuốc'),
            ),
          ],
        ),
      );
}

class _MedicationSearchField extends StatelessWidget {
  const _MedicationSearchField({required this.onTapFilter});

  final VoidCallback onTapFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const _AssetIcon(EverwellFigmaMcpRasterAssets.medSearch, size: 24),
          const SizedBox(width: 8),
          const Expanded(child: Text('Tìm kiếm...', style: TextStyle(fontSize: 16))),
          IconButton(
            onPressed: onTapFilter,
            icon: const _AssetIcon(EverwellFigmaMcpRasterAssets.medFilter, size: 24),
          ),
        ],
      ),
    );
  }
}

class _PillTab extends StatelessWidget {
  const _PillTab({required this.text, required this.active, required this.onTap});
  final String text;
  final bool active;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF276291) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFF373737),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard({
    required this.item,
    required this.statusColor,
    required this.statusBackground,
    required this.statusText,
    required this.moreTagColor,
    required this.onTap,
    this.moreTagTextColor = const Color(0xFF526772),
  });

  final dynamic item;
  final Color statusColor;
  final Color statusBackground;
  final String statusText;
  final Color moreTagColor;
  final Color moreTagTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFECF7FF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0A0061A4), blurRadius: 20, offset: Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.dateLabel, style: const TextStyle(color: Color(0xFFA7A7A7), fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(item.diagnosis, style: const TextStyle(fontSize: 31 / 1.75, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: statusBackground, borderRadius: BorderRadius.circular(999)),
                  child: Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.w700, fontSize: 11)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const _AssetIcon(EverwellFigmaMcpRasterAssets.medRowDoctor, size: 16),
                const SizedBox(width: 8),
                Text(item.doctorName, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF373737))),
                const Spacer(),
                const _AssetIcon(EverwellFigmaMcpRasterAssets.medRowChevron, size: 12),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const _AssetIcon(EverwellFigmaMcpRasterAssets.medRowHospital, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(item.hospitalName, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF373737)))),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in (item.medicineNames as List<String>).take(2))
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const _AssetIcon(EverwellFigmaMcpRasterAssets.medTagPill, size: 12),
                        const SizedBox(width: 6),
                        Text(m, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF373737))),
                      ],
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: moreTagColor, borderRadius: BorderRadius.circular(8)),
                  child: Text('+1 thuốc khác', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: moreTagTextColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.iconAsset,
    required this.title,
    required this.value,
    required this.background,
    required this.titleColor,
    this.subtitle,
    this.boldTitle = false,
    this.iconWidth = 24,
    this.iconHeight = 24,
  });
  final String iconAsset;
  final String title;
  final String value;
  final String? subtitle;
  final Color background;
  final Color titleColor;
  final bool boldTitle;
  final double iconWidth;
  final double iconHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: subtitle == null ? 104 : 122,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(iconAsset, width: iconWidth, height: iconHeight, fit: BoxFit.contain),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 12, color: titleColor, fontWeight: boldTitle ? FontWeight.w700 : FontWeight.w500)),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: subtitle == null ? 1 : 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563)),
            ),
        ],
      ),
    );
  }
}

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFF16A34A), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 28 / 1.55, fontWeight: FontWeight.w600, color: Color(0xFF373737))),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _MedicationDetailCard extends StatelessWidget {
  const _MedicationDetailCard({
    required this.name,
    required this.meta,
    required this.duration,
    required this.frequency,
    required this.dosage,
    required this.periods,
    this.note,
  });
  final String name;
  final String meta;
  final String duration;
  final String frequency;
  final String dosage;
  final List<String> periods;
  final String? note;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(color: Color(0x1A0061A4), borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Center(
                  child: _AssetIcon(
                    name == 'Omeprazole 20mg'
                        ? EverwellFigmaMcpRasterAssets.medDetailMed1
                        : EverwellFigmaMcpRasterAssets.medDetailMed2,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22 / 1.4)), Text(meta)])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(999)),
                child: Text(duration, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF373737))),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _MetricTile(title: 'LIỀU LƯỢNG', value: dosage)),
              const SizedBox(width: 8),
              Expanded(child: _MetricTile(title: 'TẦN SUẤT', value: frequency)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: periods
                .map((period) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0x80CFE6F2), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _AssetIcon(_periodIcon(period), size: 12),
                          const SizedBox(width: 4),
                          Text(period, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF585858))),
                        ],
                      ),
                    ))
                .toList(),
          ),
          if (note != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const _AssetIcon(EverwellFigmaMcpRasterAssets.medNoteWarning, size: 12),
                  const SizedBox(width: 8),
                  Text(note!, style: const TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.w700, fontSize: 11)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

String _periodIcon(String period) {
  if (period == 'Trưa') return EverwellFigmaMcpRasterAssets.medTimeNoon;
  if (period == 'Tối') return EverwellFigmaMcpRasterAssets.medTimeNight;
  return EverwellFigmaMcpRasterAssets.medTimeMorning;
}

class _AssetIcon extends StatelessWidget {
  const _AssetIcon(this.path, {required this.size});
  final String path;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Image.asset(path, width: size, height: size, fit: BoxFit.contain);
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: const Color(0xFFD2EBFF), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF373737))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class AddPrescriptionPage extends StatefulWidget {
  const AddPrescriptionPage({super.key});
  @override
  State<AddPrescriptionPage> createState() => _AddPrescriptionPageState();
}

class _AddPrescriptionPageState extends State<AddPrescriptionPage> {
  final key = GlobalKey<FormState>();
  bool _showSheet = false;
  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Thêm đơn thuốc',
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF1F4D73), Color(0xFF3A92D9)]),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(color: const Color(0x33FFFFFF), borderRadius: BorderRadius.circular(24)),
                        child: Center(
                          child: Image.asset(
                            EverwellFigmaMcpRasterAssets.medAddUploadCloud,
                            width: 42,
                            height: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text('Tải lên toa thuốc', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white)),
                      const SizedBox(height: 4),
                      const Text('Hỗ trợ các định dạng PDF, JPG, PNG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 18),
                      ElevatedButton(
                        onPressed: () => setState(() => _showSheet = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF307AB5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        ),
                        child: const Text('Chọn tệp ngay'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _UploadOption(assetPath: EverwellFigmaMcpRasterAssets.medAddUploadCamera, title: 'Chụp ảnh', color: const Color(0xFFD2EBFF), onTap: () => setState(() => _showSheet = true))),
                    const SizedBox(width: 16),
                    Expanded(child: _UploadOption(assetPath: EverwellFigmaMcpRasterAssets.medAddUploadGallery, title: 'Thư Viện', color: const Color(0xFF6EE7B7), onTap: () => setState(() => _showSheet = true))),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 170,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.black),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(EverwellFigmaMcpRasterAssets.medAddIllustration, fit: BoxFit.cover),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFFFF9E6), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFEF3C7))),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AssetIcon(EverwellFigmaMcpRasterAssets.medAddAiStar, size: 22),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Trí tuệ nhân tạo (AI)\nHệ thống sẽ tự động nhận diện chữ viết tay và tên thuốc từ hình ảnh.',
                          style: TextStyle(color: Color(0xFFB45309), fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_showSheet)
              _SuccessDialog(
                title: 'Tạo lịch nhắc nhở\nthành công!',
                subtitle: 'Bạn sẽ nhận được thông báo khi\ndến giờ uống thuốc.',
                primaryText: 'Đã hiểu',
                secondaryText: 'Xem lịch trình',
                onPrimary: () => setState(() => _showSheet = false),
                onSecondary: () {
                  setState(() => _showSheet = false);
                  context.push(AppRoutes.medicationCreateReminder);
                },
              ),
          ],
        ),
      );
}

class CreateReminderPage extends StatefulWidget {
  const CreateReminderPage({super.key});
  @override
  State<CreateReminderPage> createState() => _CreateReminderPageState();
}

class _CreateReminderPageState extends State<CreateReminderPage> {
  bool _showSuccess = false;
  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Tạo lịch nhắc nhở',
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(20)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('THỜI GIAN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF707883))),
                      SizedBox(height: 8),
                      Text('08:00 AM', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                      SizedBox(height: 8),
                      Text('LIỀU LƯỢNG', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF707883))),
                      SizedBox(height: 6),
                      Text('1 viên', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _PillWrap(items: const ['Sáng', 'Trưa', 'Tối']),
                const SizedBox(height: 14),
                _ActionButton(
                  text: 'Tạo lịch nhắc nhở',
                  onTap: () => setState(() => _showSuccess = true),
                  dark: true,
                ),
                const SizedBox(height: 12),
                _ActionButton(
                  text: 'Thêm vào tủ thuốc',
                  onTap: () => context.push(AppRoutes.medicationAddToCabinet),
                ),
              ],
            ),
            if (_showSuccess)
              _SuccessDialog(
                title: 'Tạo lịch nhắc nhở\nthành công!',
                subtitle: 'Bạn sẽ nhận được thông báo khi\ndến giờ uống thuốc.',
                primaryText: 'Đã hiểu',
                secondaryText: 'Xem lịch trình',
                onPrimary: () => setState(() => _showSuccess = false),
                onSecondary: () {
                  setState(() => _showSuccess = false);
                  context.push(AppRoutes.medicationReminderSchedule);
                },
              ),
          ],
        ),
      );
}

class AddToCabinetPage extends StatefulWidget {
  const AddToCabinetPage({super.key});
  @override
  State<AddToCabinetPage> createState() => _AddToCabinetPageState();
}

class _AddToCabinetPageState extends State<AddToCabinetPage> {
  bool _showSuccess = true;

  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Thêm vào tủ thuốc',
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
              children: const [
                SizedBox(height: 16),
                Text('Dữ liệu đơn thuốc đã sẵn sàng để thêm vào tủ thuốc.', style: TextStyle(fontSize: 16)),
              ],
            ),
            if (_showSuccess)
              _SuccessDialog(
                title: 'Thêm vào tủ thuốc\nthành công!',
                subtitle: 'Hãy quản lý tủ thuốc của bạn\nvà gia đình',
                primaryText: 'Đã hiểu',
                secondaryText: 'Xem tủ thuốc',
                onPrimary: () => setState(() => _showSuccess = false),
                onSecondary: () {
                  setState(() => _showSuccess = false);
                  context.push(AppRoutes.medicationCabinet);
                },
              ),
          ],
        ),
      );
}

class CabinetPage extends StatefulWidget {
  const CabinetPage({super.key});
  @override
  State<CabinetPage> createState() => _CabinetPageState();
}

class _CabinetPageState extends State<CabinetPage> {
  late final CabinetFlowViewModel vm;
  @override
  void initState() {
    super.initState();
    vm = CabinetFlowViewModel(_repo())..load();
  }

  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Tủ thuốc cá nhân',
        fab: FloatingActionButton(
          onPressed: () => context.push(AppRoutes.medicationChooseAddMethod),
          backgroundColor: const Color(0xFF1F4D73),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Image.asset(EverwellFigmaMcpRasterAssets.medFabPlus, width: 18, height: 18),
        ),
        body: ListenableBuilder(
          listenable: vm,
          builder: (context, _) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
              children: [
                Container(
                  height: 52,
                  decoration: BoxDecoration(color: const Color(0xFFE0E3E6), borderRadius: BorderRadius.circular(999)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(children: [Icon(Icons.search, color: Color(0xFF6B7280)), SizedBox(width: 8), Text('Tìm kiếm thuốc...', style: TextStyle(color: Color(0xFF6B7280), fontSize: 14))]),
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(child: _CabinetSummaryCard(title: 'SẮP HẾT', value: '01', subtitle: 'Sản phẩm cần mua\nthêm', accent: Color(0xFF2196F3), icon: Icons.warning_amber_rounded)),
                    SizedBox(width: 12),
                    Expanded(child: _CabinetSummaryCard(title: 'HẾT HẠN', value: '01', subtitle: 'Cần tiêu hủy an toàn', accent: Color(0xFFBA1A1A), icon: Icons.event_busy_rounded)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Danh sách thuốc', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0x1A2196F3), borderRadius: BorderRadius.circular(999)),
                      child: const Text('4 Loại', style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.w500, fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...vm.medicines.map(
                  (m) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _CabinetMedicineCard(medicine: m, onTap: () => context.push(AppRoutes.medicationMedicineDetail)),
                  ),
                ),
              ],
            );
          },
        ),
      );
}

class ChooseAddMethodPage extends StatelessWidget {
  const ChooseAddMethodPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: Color(0x22000000))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.64,
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 62,
                        height: 6,
                        decoration: BoxDecoration(color: const Color(0xFFE5E7EB), borderRadius: BorderRadius.circular(999)),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text('Chọn cách thêm thuốc', style: TextStyle(fontSize: 44 / 1.35, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    const Text('Để theo dõi lịch uống thuốc chính xác nhất, vui lòng chọn phương thức nhập thông tin phù hợp.', style: TextStyle(fontSize: 16, color: Color(0xFF4B5563))),
                    const SizedBox(height: 24),
                    _OptionRow(
                      assetPath: EverwellFigmaMcpRasterAssets.medChooseQr,
                      title: 'Quét mã thuốc',
                      subtitle: 'Sử dụng camera để nhận diện nhanh thông tin bao bì thuốc.',
                      onTap: () => context.push(AppRoutes.medicationInputMedicine),
                    ),
                    const SizedBox(height: 20),
                    _OptionRow(
                      assetPath: EverwellFigmaMcpRasterAssets.medChooseManual,
                      title: 'Nhập tay thông tin',
                      subtitle: 'Tự nhập tên thuốc, liều lượng và thời gian uống cụ thể.',
                      onTap: () => context.push(AppRoutes.medicationInputMedicine),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class InputMedicinePage extends StatefulWidget {
  const InputMedicinePage({super.key});
  @override
  State<InputMedicinePage> createState() => _InputMedicinePageState();
}

class _InputMedicinePageState extends State<InputMedicinePage> {
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Nhập thông tin thuốc',
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
          child: Form(
            key: key,
            child: ListView(
              children: [
                const Text('Ảnh hộp thuốc', style: TextStyle(fontSize: 42 / 1.35, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Container(
                  height: 168,
                  decoration: BoxDecoration(color: const Color(0xFFEFF2F5), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFD2EBFF), width: 2)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _AssetIcon(EverwellFigmaMcpRasterAssets.medInputPhoto, size: 34),
                      SizedBox(height: 8),
                      Text('Chụp hoặc tải ảnh lên', style: TextStyle(fontSize: 28 / 1.35, fontWeight: FontWeight.w600)),
                      SizedBox(height: 2),
                      Text('Hỗ trợ JPG, PNG (Tối đa 5MB)', style: TextStyle(color: Color(0xFF6E6E6E))),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  initialValue: 'Paracetamol 500mg',
                  decoration: const InputDecoration(labelText: 'Tên thuốc'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Bắt buộc' : null,
                ),
                const SizedBox(height: 14),
                const _PillSelector(title: 'Dạng bào chế', options: ['Viên nén', 'Siro/Lỏng', 'Bột', 'Tiêm']),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: TextFormField(initialValue: '1 viên', decoration: const InputDecoration(labelText: 'Liều lượng'))),
                    const SizedBox(width: 12),
                    Expanded(child: TextFormField(initialValue: '30', decoration: const InputDecoration(labelText: 'Số lượng còn'))),
                  ],
                ),
                const SizedBox(height: 14),
                TextFormField(initialValue: 'mm/dd/yyyy', decoration: const InputDecoration(labelText: 'Ngày hết hạn')),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFF0061A4)),
                      SizedBox(width: 10),
                      Expanded(child: Text('Hệ thống sẽ tự động nhắc bạn trước 30 ngày khi thuốc sắp hết hạn hoặc còn dưới 5 đơn vị sử dụng.', style: TextStyle(fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      context.push(AppRoutes.medicationMedicineDetail);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F4D73),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Lưu thông tin'),
                ),
              ],
            ),
          ),
        ),
      );
}

class MedicineDetailPage extends StatelessWidget {
  const MedicineDetailPage({super.key});
  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Chi tiết thuốc',
        body: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(24)),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(EverwellFigmaMcpRasterAssets.medDetailHeroImage, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            const Text('Augmentin 1g', style: TextStyle(fontSize: 48 / 1.35, fontWeight: FontWeight.w700)),
            const Text('Amoxicillin / Acid clavulanic', style: TextStyle(fontSize: 34 / 1.35, color: Color(0xFF3A5A74), fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(child: _DetailMetricCard(title: 'CÒN LẠI', value: '14', suffix: 'viên', danger: false)),
                SizedBox(width: 12),
                Expanded(child: _DetailMetricCard(title: 'HẾT HẠN', value: '12/2025', suffix: '', danger: true)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(20)),
              child: const Column(
                children: [
                  _LineInfo(title: 'Liều lượng', body: 'Uống 1 viên mỗi lần, 2 lần mỗi ngày (Sáng - Tối) sau khi ăn no.'),
                  Divider(height: 18),
                  _LineInfo(title: 'Chỉ định & Lưu ý', body: 'Điều trị viêm khuẩn đường hô hấp.\nKhông uống cùng đồ uống có cồn.\nUống nhiều nước trong ngày.'),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFD2EBFF), borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  const CircleAvatar(radius: 22, backgroundColor: Color(0xFF0061A4), child: _AssetIcon(EverwellFigmaMcpRasterAssets.medCtaBell, size: 20)),
                  const SizedBox(width: 12),
                  const Expanded(child: Text('Lịch nhắc tiếp theo\nHôm nay, 20:00', style: TextStyle(fontWeight: FontWeight.w700))),
                  CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Image.asset(EverwellFigmaMcpRasterAssets.medCtaCabinet, width: 20, height: 20)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push(AppRoutes.medicationEditMedicine),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F4D73),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Chỉnh sửa thuốc'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.push(AppRoutes.medicationReminderSchedule),
              child: const Text('Mở lịch nhắc nhở'),
            ),
          ],
        ),
      );
}

class EditMedicinePage extends StatefulWidget {
  const EditMedicinePage({super.key});
  @override
  State<EditMedicinePage> createState() => _EditMedicinePageState();
}

class _EditMedicinePageState extends State<EditMedicinePage> {
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Chỉnh sửa thuốc',
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
          child: Form(
            key: key,
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: const Color(0x1A0061A4),
                  child: Image.asset(EverwellFigmaMcpRasterAssets.medEditHeroPill, width: 36, height: 36),
                ),
                const SizedBox(height: 16),
                const Text('Paracetamol 500mg', style: TextStyle(fontSize: 46 / 1.35, fontWeight: FontWeight.w700)),
                const Text('Cập nhật thông tin chi tiết thuốc trong tủ của bạn', style: TextStyle(color: Color(0xFF4B5563), fontSize: 28 / 1.35)),
                const SizedBox(height: 18),
                TextFormField(
                  initialValue: 'Paracetamol 500mg',
                  decoration: const InputDecoration(labelText: 'Tên thuốc'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Bắt buộc' : null,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: TextFormField(initialValue: '1', decoration: const InputDecoration(labelText: 'Liều lượng'))),
                    const SizedBox(width: 12),
                    Expanded(child: TextFormField(initialValue: '12', decoration: const InputDecoration(labelText: 'Số lượng'))),
                  ],
                ),
                const SizedBox(height: 14),
                TextFormField(initialValue: '12/31/2025', decoration: const InputDecoration(labelText: 'Ngày hết hạn')),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: const Color(0xFFD2EBFF), borderRadius: BorderRadius.circular(20)),
                  child: const Text('GHI CHÚ HƯỚNG DẪN\nUống sau khi ăn no, Tối đa 4 viên/ngày, cách nhau ít nhất 4-6 tiếng.', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      context.pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F4D73),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Lưu thay đổi'),
                ),
                const SizedBox(height: 10),
                const Center(child: Text('Cập nhật lần cuối: 12 tháng 10, 2023', style: TextStyle(color: Color(0xFF9CA3AF)))),
              ],
            ),
          ),
        ),
      );
}

class ReminderSchedulePage extends StatefulWidget {
  const ReminderSchedulePage({super.key});
  @override
  State<ReminderSchedulePage> createState() => _ReminderSchedulePageState();
}

class _ReminderSchedulePageState extends State<ReminderSchedulePage> {
  late final ReminderFlowViewModel vm;
  @override
  void initState() {
    super.initState();
    vm = ReminderFlowViewModel(_repo())..load();
  }

  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Lịch nhắc nhở',
        body: ListenableBuilder(
          listenable: vm,
          builder: (context, _) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('HÔM NAY', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF334155))),
                            SizedBox(height: 6),
                            Text('Thứ Sáu,\n3 tháng 4', style: TextStyle(fontSize: 52 / 1.35, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      CircleAvatar(radius: 24, backgroundColor: Color(0xFFD2EBFF), child: Icon(Icons.calendar_month_rounded, color: Color(0xFF0061A4))),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            context.push(AppRoutes.medicationAdherenceHistory),
                        child: const Text('Xem tiến độ'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            context.push(AppRoutes.medicationReminderSettings),
                        child: const Text('Cài đặt'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const _PeriodHeading(title: 'Sáng', range: '06:00 - 11:59'),
                const SizedBox(height: 10),
                ...vm.reminders.map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ReminderRow(
                        time: r.timeLabel,
                        name: r.medicineName,
                        note: r.note,
                        status: r.taken ? 'ĐÃ UỐNG' : 'CHỜ',
                        onTap: () => context.push(AppRoutes.medicationConfirmTaken),
                      ),
                    )),
                const SizedBox(height: 8),
                const _PeriodHeading(title: 'Chiều', range: '14:00 - 17:59', empty: true),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(16)),
                  child: const Row(
                    children: [
                      CircleAvatar(radius: 16, backgroundColor: Color(0xFFD2EBFF), child: Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF0061A4))),
                      SizedBox(width: 8),
                      CircleAvatar(radius: 16, backgroundColor: Color(0xFF9EF6A8), child: Icon(Icons.link, size: 14, color: Color(0xFF006E1C))),
                      SizedBox(width: 10),
                      Text('2 medications pending', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28 / 1.35)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
}

class ReminderSettingsPage extends StatefulWidget {
  const ReminderSettingsPage({super.key});
  @override
  State<ReminderSettingsPage> createState() => _ReminderSettingsPageState();
}

class _ReminderSettingsPageState extends State<ReminderSettingsPage> {
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Cài đặt nhắc nhở',
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
          child: Form(
            key: key,
            child: ListView(
              children: [
                const Row(
                  children: [
                    Text('Chọn thuốc từ tủ', style: TextStyle(fontSize: 44 / 1.35, fontWeight: FontWeight.w700)),
                    Spacer(),
                    Text('Xem tất cả', style: TextStyle(color: Color(0xFF0061A4), fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 10),
                const _SelectedMedicineTile(name: 'Paracetamol 500mg', sub: 'Còn 15 viên trong tủ', selected: true),
                const SizedBox(height: 10),
                const _SelectedMedicineTile(name: 'Vitamin C', sub: 'Còn 30 viên trong tủ'),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Color(0xFF374151)),
                  label: const Text('Thêm thuốc mới vào tủ', style: TextStyle(color: Color(0xFF374151))),
                  style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                ),
                const SizedBox(height: 16),
                const Text('Thời gian & Liều lượng', style: TextStyle(fontSize: 42 / 1.35, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                _DoseBlock(onDelete: () {}, time: '08:00 AM', dose: '1'),
                const SizedBox(height: 10),
                _DoseBlock(onDelete: () {}, time: '08:00 PM', dose: '1'),
                const SizedBox(height: 8),
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.add_circle_outline, color: Color(0xFF0061A4)), label: const Text('Thêm khung giờ uống', style: TextStyle(color: Color(0xFF0061A4), fontWeight: FontWeight.w700))),
                const SizedBox(height: 12),
                const Text('Thời gian điều trị', style: TextStyle(fontSize: 42 / 1.35, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                TextFormField(initialValue: '05/20/2024', decoration: const InputDecoration(labelText: 'Ngày bắt đầu'), validator: (v) => (v == null || v.isEmpty) ? 'Bắt buộc' : null),
                const SizedBox(height: 10),
                TextFormField(initialValue: '05/27/2024', decoration: const InputDecoration(labelText: 'Ngày kết thúc'), validator: (v) => (v == null || v.isEmpty) ? 'Bắt buộc' : null),
                const SizedBox(height: 12),
                const Text('Ghi chú & Nhắc nhở', style: TextStyle(fontSize: 42 / 1.35, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                TextFormField(maxLines: 2, initialValue: 'Uống sau khi ăn, không dùng chung với sữa...'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      context.push(AppRoutes.medicationCreateReminder);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F4D73),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Lưu lịch nhắc nhở'),
                ),
              ],
            ),
          ),
        ),
      );
}

class AdherenceHistoryPage extends StatefulWidget {
  const AdherenceHistoryPage({super.key});
  @override
  State<AdherenceHistoryPage> createState() => _AdherenceHistoryPageState();
}

class _AdherenceHistoryPageState extends State<AdherenceHistoryPage> {
  late final ReminderFlowViewModel vm;
  @override
  void initState() {
    super.initState();
    vm = ReminderFlowViewModel(_repo())..load();
  }

  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
        title: 'Lịch sử tuân thủ',
        body: ListenableBuilder(
          listenable: vm,
          builder: (context, _) => ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
            children: [
              const _AdherenceCalendarHeader(),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(child: _AdherenceStatCard(title: 'Tỉ lệ tuân thủ', value: '85%', dark: true)),
                  SizedBox(width: 10),
                  Expanded(child: _AdherenceStatCard(title: 'ĐÃ UỐNG', value: '12 liều', success: true)),
                ],
              ),
              const SizedBox(height: 10),
              const _AdherenceStatCard(title: 'BỎ LỠ', value: '2 liều', error: true),
              const SizedBox(height: 14),
              const Text('Lịch sử chi tiết', style: TextStyle(fontSize: 44 / 1.35, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              ...vm.history.map((e) => _AdherenceItem(event: e)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(16)),
                child: const Text('Làm tốt lắm!\nBạn đã duy trì 85% tỉ lệ tuân thủ trong 7 ngày qua.', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      );
}

class ConfirmTakenPage extends StatelessWidget {
  const ConfirmTakenPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0x99000000),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 132,
                  decoration: const BoxDecoration(color: Color(0xFF1F4D73), borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
                  child: const Center(child: CircleAvatar(radius: 36, backgroundColor: Color(0xFF2D5F8A), child: Icon(Icons.notifications_active_rounded, color: Colors.white, size: 32))),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      const Text('Xác nhận uống thuốc', style: TextStyle(fontSize: 46 / 1.35, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      const Text('Vui lòng xác nhận bạn đã uống thuốc theo đúng chỉ định của bác sĩ', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: const Color(0xFFF8FBFF), borderRadius: BorderRadius.circular(16)),
                        child: const Row(
                          children: [
                            CircleAvatar(radius: 20, backgroundColor: Color(0xFFD2EBFF), child: Icon(Icons.medication_rounded, color: Color(0xFF0061A4))),
                            SizedBox(width: 10),
                            Expanded(child: Text('Omeprazole 20mg', style: TextStyle(fontSize: 40 / 1.35, fontWeight: FontWeight.w700))),
                            SizedBox(width: 8),
                            DecoratedBox(
                              decoration: BoxDecoration(color: Color(0xFFD2EBFF), borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                child: Text('1 viên', style: TextStyle(color: Color(0xFF0061A4), fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _ActionButton(text: 'Đã uống', dark: true, onTap: () => context.pop()),
                      const SizedBox(height: 10),
                      _ActionButton(text: 'Bỏ qua', onTap: () => context.pop()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _UploadOption extends StatelessWidget {
  const _UploadOption({required this.assetPath, required this.title, required this.color, required this.onTap});
  final String assetPath;
  final String title;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 148,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 20, offset: Offset(0, 4))]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 28, backgroundColor: color, child: Image.asset(assetPath, width: 24, height: 24)),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 34 / 1.35, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({
    required this.title,
    required this.subtitle,
    required this.primaryText,
    required this.secondaryText,
    required this.onPrimary,
    required this.onSecondary,
  });
  final String title;
  final String subtitle;
  final String primaryText;
  final String secondaryText;
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Color(0x99000000)),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(26)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(radius: 26, backgroundColor: Color(0xFFE7F9E7), child: Icon(Icons.check, color: Color(0xFF16A34A), size: 30)),
                const SizedBox(height: 16),
                Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 46 / 1.35, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Color(0xFF4B5563))),
                const SizedBox(height: 14),
                _ActionButton(text: primaryText, dark: true, onTap: onPrimary),
                const SizedBox(height: 10),
                TextButton(onPressed: onSecondary, child: Text(secondaryText)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.text, required this.onTap, this.dark = false});
  final String text;
  final VoidCallback onTap;
  final bool dark;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: dark ? const Color(0xFF1F4D73) : const Color(0xFFE5E5E5),
          foregroundColor: dark ? Colors.white : const Color(0xFF373737),
          minimumSize: const Size(double.infinity, 56),
          elevation: dark ? 3 : 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 36 / 1.35, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _CabinetSummaryCard extends StatelessWidget {
  const _CabinetSummaryCard({required this.title, required this.value, required this.subtitle, required this.accent, required this.icon});
  final String title;
  final String value;
  final String subtitle;
  final Color accent;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 16, 16),
      decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(16), border: Border(left: BorderSide(color: accent, width: 4))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, color: accent, size: 18), const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 12, letterSpacing: .6, fontWeight: FontWeight.w700, color: Color(0xFF404752)))]), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w700, height: 1)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF707883)))]),
    );
  }
}

class _CabinetMedicineCard extends StatelessWidget {
  const _CabinetMedicineCard({required this.medicine, required this.onTap});
  final dynamic medicine;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final isLow = medicine.status.toString().contains('lowStock');
    final isExpired = medicine.status.toString().contains('expired');
    final badgeColor = isExpired ? const Color(0xFFBA1A1A) : (isLow ? const Color(0xFF2196F3) : const Color(0x1A42A547));
    final badgeTextColor = isExpired ? Colors.white : (isLow ? Colors.white : const Color(0xFF006E1C));
    final badgeText = isExpired ? 'HẾT HẠN' : (isLow ? 'SẮP HẾT' : 'BÌNH THƯỜNG');
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            CircleAvatar(radius: 24, backgroundColor: isExpired ? const Color(0x1ABA1A1A) : const Color(0x4D9ECAFF), child: Icon(isExpired ? Icons.event_busy_rounded : Icons.medication_rounded, color: isExpired ? const Color(0xFFBA1A1A) : const Color(0xFF0061A4))),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(medicine.name, style: const TextStyle(fontSize: 40 / 1.35, fontWeight: FontWeight.w700)), Text(isExpired ? 'Hết hạn: ${medicine.expiryLabel}' : 'Còn ${medicine.quantityLeft} viên', style: TextStyle(fontSize: 32 / 1.35, color: isExpired ? const Color(0xFFBA1A1A) : const Color(0xFF707883), fontWeight: isExpired ? FontWeight.w600 : FontWeight.w400))])),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(999)),
                  child: Text(badgeText, style: TextStyle(color: badgeTextColor, fontSize: 11, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 6),
                Icon(isLow ? Icons.notifications_active_outlined : (isExpired ? Icons.priority_high : Icons.chevron_right), color: isExpired ? const Color(0xFFBA1A1A) : const Color(0xFFA7A7A7), size: isLow ? 20 : 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({required this.assetPath, required this.title, required this.subtitle, required this.onTap});
  final String assetPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(color: const Color(0xFFD2EBFF), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Image.asset(assetPath, width: 24, height: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 38 / 1.35, fontWeight: FontWeight.w700)), Text(subtitle, style: const TextStyle(fontSize: 16, color: Color(0xFF4B5563)))])),
        ],
      ),
    );
  }
}

class _PillSelector extends StatelessWidget {
  const _PillSelector({required this.title, required this.options});
  final String title;
  final List<String> options;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 28 / 1.35)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options
                .map((o) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(color: o == options.first ? const Color(0xFF0061A4) : const Color(0xFFE0E3E6), borderRadius: BorderRadius.circular(999)),
                      child: Text(o, style: TextStyle(color: o == options.first ? Colors.white : const Color(0xFF4B5563), fontWeight: FontWeight.w600)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _DetailMetricCard extends StatelessWidget {
  const _DetailMetricCard({required this.title, required this.value, required this.suffix, required this.danger});
  final String title;
  final String value;
  final String suffix;
  final bool danger;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF707883), fontWeight: FontWeight.w700)), const SizedBox(height: 6), Text(value, style: const TextStyle(fontSize: 44 / 1.35, fontWeight: FontWeight.w700)), if (suffix.isNotEmpty) Text(suffix, style: TextStyle(color: danger ? const Color(0xFFBA1A1A) : const Color(0xFF4B5563)))]),
    );
  }
}

class _LineInfo extends StatelessWidget {
  const _LineInfo({required this.title, required this.body});
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.medical_information_outlined, color: Color(0xFF0061A4))),
        const SizedBox(width: 10),
        Expanded(child: Text('$title\n$body', style: const TextStyle(fontWeight: FontWeight.w600))),
      ],
    );
  }
}

class _PillWrap extends StatelessWidget {
  const _PillWrap({required this.items});
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: items
          .map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFD2EBFF), borderRadius: BorderRadius.circular(999)),
              child: Text(e, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            ),
          )
          .toList(),
    );
  }
}

class _PeriodHeading extends StatelessWidget {
  const _PeriodHeading({required this.title, required this.range, this.empty = false});
  final String title;
  final String range;
  final bool empty;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [CircleAvatar(radius: 16, backgroundColor: const Color(0xFFFFF0DC), child: Icon(title == 'Chiều' ? Icons.wb_twilight_rounded : Icons.wb_sunny_rounded, color: title == 'Chiều' ? const Color(0xFFFF91A4) : const Color(0xFFF59E0B))), const SizedBox(width: 10), Text(title, style: TextStyle(fontSize: 42 / 1.35, fontWeight: FontWeight.w700, color: empty ? const Color(0xFF9CA3AF) : Colors.black)), const SizedBox(width: 10), Text(range, style: const TextStyle(color: Color(0xFF6B7280)))]),
        if (empty) ...[
          const SizedBox(height: 10),
          Container(
            height: 74,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFD2EBFF), style: BorderStyle.solid)),
            child: const Center(child: Text('Không có lịch', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 32 / 1.35))),
          ),
        ],
      ],
    );
  }
}

class _ReminderRow extends StatelessWidget {
  const _ReminderRow({required this.time, required this.name, required this.note, required this.status, required this.onTap});
  final String time;
  final String name;
  final String note;
  final String status;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(width: 4, height: 82, decoration: const BoxDecoration(color: Color(0xFF0061A4), borderRadius: BorderRadius.horizontal(left: Radius.circular(14)))),
            const SizedBox(width: 12),
            Text(time, style: const TextStyle(fontSize: 34 / 1.35, color: Color(0xFF334155))),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontSize: 38 / 1.35, fontWeight: FontWeight.w700)), Text(note, style: const TextStyle(fontSize: 30 / 1.35, color: Color(0xFF374151)))])),
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFD2EBFF), borderRadius: BorderRadius.circular(999)),
              child: Text(status, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF526772))),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedMedicineTile extends StatelessWidget {
  const _SelectedMedicineTile({required this.name, required this.sub, this.selected = false});
  final String name;
  final String sub;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFECF7FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: selected ? const Color(0xFF0061A4) : Colors.transparent, width: 2),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: const Color(0xFFD2EBFF), child: Icon(selected ? Icons.medication_rounded : Icons.medication_outlined, color: const Color(0xFF0061A4))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontSize: 34 / 1.35, fontWeight: FontWeight.w700)), Text(sub, style: const TextStyle(color: Color(0xFF6B7280)))])),
          if (selected) const Icon(Icons.check_circle, color: Color(0xFF0061A4)),
        ],
      ),
    );
  }
}

class _DoseBlock extends StatelessWidget {
  const _DoseBlock({required this.onDelete, required this.time, required this.dose});
  final VoidCallback onDelete;
  final String time;
  final String dose;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextFormField(initialValue: time, decoration: const InputDecoration(labelText: 'THỜI GIAN'))),
              const SizedBox(width: 12),
              Expanded(child: TextFormField(initialValue: dose, decoration: const InputDecoration(labelText: 'LIỀU LƯỢNG'))),
              const SizedBox(width: 8),
              const Text('viên'),
            ],
          ),
          Align(alignment: Alignment.centerLeft, child: IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline, color: Color(0xFFDC2626)))),
        ],
      ),
    );
  }
}

class _AdherenceCalendarHeader extends StatelessWidget {
  const _AdherenceCalendarHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [Text('THÁNG 10, 2023', style: TextStyle(color: Color(0xFF707883), fontSize: 28 / 1.35, fontWeight: FontWeight.w600)), Spacer(), Icon(Icons.chevron_left), Icon(Icons.chevron_right)]),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _DayDot(day: '16', color: Color(0xFF16A34A)),
              _DayDot(day: '17', color: Color(0xFF16A34A)),
              _DayDot(day: '18', color: Color(0xFFDC2626)),
              _DayDot(day: '19', color: Color(0xFF0061A4), selected: true),
              _DayDot(day: '20', color: Color(0xFFE5E7EB)),
              _DayDot(day: '21', color: Color(0xFFE5E7EB)),
              _DayDot(day: '22', color: Color(0xFFE5E7EB)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.day, required this.color, this.selected = false});
  final String day;
  final Color color;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: selected ? const Color(0xFF0061A4) : color,
      child: Text(day, style: TextStyle(color: selected ? Colors.white : Colors.black, fontWeight: FontWeight.w700)),
    );
  }
}

class _AdherenceStatCard extends StatelessWidget {
  const _AdherenceStatCard({required this.title, required this.value, this.dark = false, this.success = false, this.error = false});
  final String title;
  final String value;
  final bool dark;
  final bool success;
  final bool error;
  @override
  Widget build(BuildContext context) {
    final bg = dark
        ? const Color(0xFF1F4D73)
        : success
            ? const Color(0xFF34D37C)
            : error
                ? const Color(0xFFFFF0F0)
                : const Color(0xFFECF7FF);
    final fg = dark ? Colors.white : const Color(0xFF111827);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(color: fg, fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(value, style: TextStyle(color: fg, fontSize: 36 / 1.35, fontWeight: FontWeight.w700))]),
    );
  }
}

class _AdherenceItem extends StatelessWidget {
  const _AdherenceItem({required this.event});
  final dynamic event;
  @override
  Widget build(BuildContext context) {
    final taken = event.statusLabel.toString().toLowerCase().contains('đã');
    final skipped = event.statusLabel.toString().toLowerCase().contains('bỏ');
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFECF7FF), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          CircleAvatar(radius: 22, backgroundColor: taken ? const Color(0xFF9EF6A8) : (skipped ? const Color(0xFFFFE6E6) : const Color(0xFFD2EBFF)), child: Icon(taken ? Icons.check : (skipped ? Icons.close : Icons.schedule), color: taken ? const Color(0xFF006E1C) : (skipped ? const Color(0xFFBA1A1A) : const Color(0xFF334155)))),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(event.medicineName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 34 / 1.35)), Text('${event.dateTimeLabel}   ${event.statusLabel}', style: TextStyle(color: skipped ? const Color(0xFFBA1A1A) : const Color(0xFF4B5563)))])),
          Icon(taken ? Icons.check_circle : (skipped ? Icons.cancel_outlined : Icons.more_horiz), color: taken ? const Color(0xFF16A34A) : (skipped ? const Color(0xFFDC2626) : const Color(0xFF94A3B8))),
        ],
      ),
    );
  }
}
