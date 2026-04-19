import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/everwell_figma_mcp_raster_assets.dart';
import '../../../../core/presentation/theme/everwell_figma_text.dart';
import '../../../../core/presentation/theme/figma_tokens.dart';
import '../../../../core/presentation/widgets/everwell_bottom_tab_bar.dart';
import '../../domain/models/health_tracking_models.dart';
import '../../health_tracking_scope.dart';
import '../view_models/heart_rate_view_models.dart';

// Figma node-id: 806:6741 (E1) — Nhịp tim/Nhập nhịp tim.
class HeartRateInputPage extends StatefulWidget {
  const HeartRateInputPage({super.key});

  @override
  State<HeartRateInputPage> createState() => _HeartRateInputPageState();
}

class _HeartRateInputPageState extends State<HeartRateInputPage> {
  late final HeartRateInputViewModel _vm;
  final _formKey = GlobalKey<FormState>();
  final _bpmController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vm = HeartRateInputViewModel(healthTrackingRepository)..setBpm(72);
    _bpmController.text = '72';
  }

  @override
  void dispose() {
    _vm.dispose();
    _bpmController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _vm.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date != null) _vm.setDate(date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _vm.selectedTime ?? const TimeOfDay(hour: 9, minute: 30),
    );
    if (time != null) _vm.setTime(time);
  }

  Future<void> _save() async {
    final ok = _formKey.currentState!.validate();
    if (!ok) return;
    _vm.setBpm(int.parse(_bpmController.text));
    _vm.setNote(_noteController.text);
    await _vm.save();
    if (!mounted) return;
    context.push(AppRoutes.healthHeartDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F9FA), Color(0xFFFFFFFF)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: ListenableBuilder(
            listenable: _vm,
            builder: (context, _) => Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 56,
                          height: 56,
                          child: Material(
                            color: AppColors.primary100,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => Navigator.of(context).maybePop(),
                              customBorder: const CircleBorder(),
                              child: Center(
                                child: Image.asset(
                                  EverwellFigmaMcpRasterAssets
                                      .healthE1BackArrow,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Nhập nhịp tim',
                            textAlign: TextAlign.center,
                            style: EverwellFigmaText.quicksandSemi(
                              20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 56),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 24),
                      children: [
                        _HeartRateHeroCard(
                          bpmController: _bpmController,
                          onMinus: () {
                            _vm.decreaseBpm();
                            _bpmController.text = (_vm.bpm ?? 72).toString();
                          },
                          onPlus: () {
                            _vm.increaseBpm();
                            _bpmController.text = (_vm.bpm ?? 72).toString();
                          },
                        ),
                        const SizedBox(height: 16),
                        _Label('Thời gian đo'),
                        const SizedBox(height: 8),
                        _InputShell(
                          glass: true,
                          child: Column(
                            children: [
                              _DateTimeRow(
                                iconAsset: EverwellFigmaMcpRasterAssets
                                    .healthE1Calendar,
                                value: _formatDateUs(_vm.selectedDate),
                                onTap: _pickDate,
                              ),
                              const SizedBox(height: 12),
                              _DateTimeRow(
                                iconAsset:
                                    EverwellFigmaMcpRasterAssets.healthE1Clock,
                                value: _vm.selectedTime == null
                                    ? '--:--'
                                    : _vm.selectedTime!.format(context),
                                onTap: _pickTime,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _Label('Trạng thái'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _PillChoice(
                                text: 'Nghỉ',
                                active: _vm.isResting,
                                iconAsset: EverwellFigmaMcpRasterAssets
                                    .healthE1StatusRest,
                                onTap: () => _vm.setResting(true),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _PillChoice(
                                text: 'Vận động',
                                active: !_vm.isResting,
                                iconAsset: EverwellFigmaMcpRasterAssets
                                    .healthE1StatusActivity,
                                onTap: () => _vm.setResting(false),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _Label('Ghi chú (tùy chọn)'),
                        const SizedBox(height: 8),
                        _InputShell(
                          glass: true,
                          child: TextFormField(
                            controller: _noteController,
                            minLines: 3,
                            maxLines: 3,
                            style: EverwellFigmaText.quicksandSemi(
                              14,
                              color: FigmaTokens.gray373737,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  'Thêm ghi chú về cảm giác, hoạt động trước đó...',
                              hintStyle: EverwellFigmaText.quicksandSemi(
                                14,
                                color: const Color(0xFF9CA3AF),
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _Label('Giá trị thường dùng'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: [60, 72, 80, 100]
                              .map(
                                (value) => Material(
                                  color: const Color(0x33FFFFFF),
                                  borderRadius: BorderRadius.circular(999),
                                  child: InkWell(
                                    onTap: () {
                                      _vm.setBpm(value);
                                      _bpmController.text = value.toString();
                                    },
                                    borderRadius: BorderRadius.circular(999),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 17,
                                        vertical: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(999),
                                        border: Border.all(
                                          color: const Color(0x80FFFFFF),
                                        ),
                                      ),
                                      child: Text(
                                        '$value BPM',
                                        style: EverwellFigmaText.quicksandSemi(
                                          14,
                                          color: FigmaTokens.gray373737,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        Material(
                          elevation: 6,
                          shadowColor: const Color(0x1A000000),
                          borderRadius: BorderRadius.circular(999),
                          color: AppColors.primary900,
                          child: SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: _vm.isSaving ? null : _save,
                              icon: Image.asset(
                                EverwellFigmaMcpRasterAssets.healthE1Save,
                                width: 14,
                                height: 14,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Lưu số đo',
                                style: EverwellFigmaText.interMedium(
                                  16,
                                  color: Colors.white,
                                ),
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primary900,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: const StadiumBorder(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.of(context).maybePop(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0x80FFFFFF)),
                              shape: const StadiumBorder(),
                              backgroundColor: const Color(0x33FFFFFF),
                            ),
                            icon: Image.asset(
                              EverwellFigmaMcpRasterAssets.healthE1Cancel,
                              width: 12,
                              height: 12,
                              color: FigmaTokens.gray373737,
                            ),
                            label: Text(
                              'Hủy',
                              style: EverwellFigmaText.interMedium(
                                16,
                                color: FigmaTokens.gray373737,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  EverwellBottomTabBar(
                    activeIndex: 0,
                    tabAssets: EverwellTabMcpAssets.homeScreen,
                    onHome: () => context.go(AppRoutes.home),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeartRateHeroCard extends StatelessWidget {
  const _HeartRateHeroCard({
    required this.bpmController,
    required this.onMinus,
    required this.onPlus,
  });

  final TextEditingController bpmController;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x1AFFFFFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            spreadRadius: -3,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 6,
            spreadRadius: -4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Nhịp tim (BPM)',
            style: EverwellFigmaText.quicksandSemi(
              14,
              color: const Color(0xCCFFFFFF),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 128,
                child: TextFormField(
                  controller: bpmController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: EverwellFigmaText.interBold(
                    48,
                    color: const Color(0xFFF9FAFB),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0x33FFFFFF),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0x4DFFFFFF),
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0x4DFFFFFF),
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nhập BPM';
                    }
                    final parsed = int.tryParse(value.trim());
                    if (parsed == null) return 'BPM không hợp lệ';
                    if (parsed < 30 || parsed > 220) return 'Giá trị 30-220';
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'BPM',
                style: EverwellFigmaText.quicksandSemi(24, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Nhập giá trị từ 30-220',
            style: EverwellFigmaText.quicksandMedium(
              12,
              color: const Color(0xB3FFFFFF),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RoundIconButton(
                iconAsset: EverwellFigmaMcpRasterAssets.healthE1Minus,
                onTap: onMinus,
              ),
              const SizedBox(width: 10),
              _RoundIconButton(
                iconAsset: EverwellFigmaMcpRasterAssets.healthE1Plus,
                onTap: onPlus,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.iconAsset, required this.onTap});
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Color(0x33FFFFFF),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(
            iconAsset,
            width: 16,
            height: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _InputShell extends StatelessWidget {
  const _InputShell({required this.child, this.glass = false});
  final Widget child;
  final bool glass;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(glass ? 17 : 16),
      decoration: BoxDecoration(
        color: glass ? const Color(0x80FFFFFF) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: glass ? const Color(0x80FFFFFF) : Colors.transparent,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _DateTimeRow extends StatelessWidget {
  const _DateTimeRow({
    required this.iconAsset,
    required this.value,
    required this.onTap,
  });

  final String iconAsset;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            iconAsset,
            width: 16,
            height: 16,
            color: AppColors.primary700,
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: EverwellFigmaText.quicksandSemi(
              14,
              color: const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: EverwellFigmaText.quicksandSemi(
          14,
          color: FigmaTokens.gray373737,
        ),
      ),
    );
  }
}

class _PillChoice extends StatelessWidget {
  const _PillChoice({
    required this.text,
    required this.active,
    required this.iconAsset,
    required this.onTap,
  });

  final String text;
  final bool active;
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(99),
      child: Container(
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? AppColors.primary900 : const Color(0x33FFFFFF),
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
            color: active ? const Color(0x1AFFFFFF) : const Color(0x80FFFFFF),
          ),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 15,
                    spreadRadius: -3,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 6,
                    spreadRadius: -4,
                    offset: Offset(0, 4),
                  ),
                ]
              : const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconAsset,
              width: 16,
              height: 16,
              color: active ? Colors.white : FigmaTokens.gray373737,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: EverwellFigmaText.quicksandSemi(
                14,
                color: active ? Colors.white : FigmaTokens.gray373737,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Figma node-id: 806:7695 (E2) — Chi tiết Nhịp tim.
class HeartRateDetailPage extends StatefulWidget {
  const HeartRateDetailPage({super.key});

  @override
  State<HeartRateDetailPage> createState() => _HeartRateDetailPageState();
}

class _HeartRateDetailPageState extends State<HeartRateDetailPage> {
  late final HeartRateDetailViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = HeartRateDetailViewModel(healthTrackingRepository)..load();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F9FA), Color(0xFFFFFFFF)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: ListenableBuilder(
            listenable: _vm,
            builder: (context, _) {
              if (_vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (_vm.error != null) {
                return Center(child: Text(_vm.error!));
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 56,
                          height: 56,
                          child: Material(
                            color: AppColors.primary100,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => context.pop(),
                              customBorder: const CircleBorder(),
                              child: Center(
                                child: Image.asset(
                                  EverwellFigmaMcpRasterAssets.healthE2BackArrow,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Chi tiết Nhịp tim',
                            textAlign: TextAlign.center,
                            style: EverwellFigmaText.quicksandSemi(20),
                          ),
                        ),
                        const SizedBox(width: 56),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(14, 16, 14, 24),
                      children: [
                        Row(
                          children: const [
                            Expanded(
                              child: _PeriodTab(label: '7 ngày', active: true),
                            ),
                            SizedBox(width: 8),
                            Expanded(child: _PeriodTab(label: '30 ngày')),
                            SizedBox(width: 8),
                            Expanded(child: _PeriodTab(label: 'Tuỳ chọn')),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _InputShell(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'So sánh với kỳ trước',
                                      style: EverwellFigmaText.quicksandSemi(14),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Hiển thị dữ liệu 2 khoảng thời gian',
                                      style: EverwellFigmaText.quicksandRegular(
                                        12,
                                        color: FigmaTokens.gray6B7280,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.toggle_off,
                                color: Color(0xFFA7A7A7),
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _ChartCard(points: _vm.trend),
                        const SizedBox(height: 16),
                        Text(
                          'Bản ghi dữ liệu',
                          style: EverwellFigmaText.quicksandSemi(36 / 1.5),
                        ),
                        const SizedBox(height: 12),
                        ..._vm.records.map(
                          (record) => _RecordCard(record: record),
                        ),
                      ],
                    ),
                  ),
                  EverwellBottomTabBar(
                    activeIndex: 0,
                    tabAssets: EverwellTabMcpAssets.homeScreen,
                    onHome: () => context.go(AppRoutes.home),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PeriodTab extends StatelessWidget {
  const _PeriodTab({required this.label, this.active = false});
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: active
            ? const LinearGradient(
                colors: [Color(0xFF1E7CFB), Color(0xFF003676)],
              )
            : null,
        color: active ? null : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0x1A000000)),
      ),
      child: Text(
        label,
        style: EverwellFigmaText.quicksandSemi(
          14,
          color: active ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.points});
  final List<HeartRateTrendPoint> points;

  @override
  Widget build(BuildContext context) {
    return _InputShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Biểu đồ chi tiết',
                style: EverwellFigmaText.quicksandSemi(20),
              ),
              const Spacer(),
              const Icon(Icons.remove, size: 20),
              const SizedBox(width: 12),
              const Icon(Icons.add, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: CustomPaint(
              size: const Size(double.infinity, 220),
              painter: _HeartTrendPainter(points),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeartTrendPainter extends CustomPainter {
  _HeartTrendPainter(this.points);
  final List<HeartRateTrendPoint> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) {
      return;
    }
    const minY = 50.0;
    const maxY = 100.0;
    const leftPad = 28.0;
    const bottomPad = 26.0;
    final chartW = size.width - leftPad;
    final chartH = size.height - bottomPad;

    final offsets = <Offset>[];
    for (var i = 0; i < points.length; i++) {
      final p = points[i];
      final x = leftPad + chartW * (i / math.max(1, points.length - 1));
      final y = chartH - ((p.bpm - minY) / (maxY - minY)) * chartH;
      offsets.add(Offset(x, y));
    }

    final axisPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var i = 0; i <= 5; i++) {
      final y = chartH - (chartH / 5 * i);
      canvas.drawLine(Offset(leftPad, y), Offset(size.width, y), axisPaint);
    }

    final fillPath = Path()..moveTo(offsets.first.dx, offsets.first.dy);
    for (var i = 1; i < offsets.length; i++) {
      fillPath.lineTo(offsets[i].dx, offsets[i].dy);
    }
    fillPath
      ..lineTo(offsets.last.dx, chartH)
      ..lineTo(offsets.first.dx, chartH)
      ..close();

    final fillRect = Rect.fromLTRB(leftPad, 0, size.width, chartH);
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x401E76FF), Color(0x001E76FF)],
        ).createShader(fillRect),
    );

    final linePath = Path()..moveTo(offsets.first.dx, offsets.first.dy);
    for (var i = 1; i < offsets.length; i++) {
      linePath.lineTo(offsets[i].dx, offsets[i].dy);
    }
    final linePaint = Paint()
      ..color = const Color(0xFF1E76FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawPath(linePath, linePaint);

    final dotPaint = Paint()..color = const Color(0xFF1E76FF);
    for (var i = 0; i < offsets.length; i++) {
      canvas.drawCircle(offsets[i], 3, dotPaint);
      final labelPainter = TextPainter(
        text: TextSpan(
          text: points[i].label,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      labelPainter.paint(
        canvas,
        Offset(offsets[i].dx - labelPainter.width / 2, chartH + 4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HeartTrendPainter oldDelegate) =>
      oldDelegate.points != points;
}

class _RecordCard extends StatelessWidget {
  const _RecordCard({required this.record});
  final HeartRateRecord record;

  @override
  Widget build(BuildContext context) {
    final status = record.bpm >= 90 ? 'Cao' : 'Bình thường';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.primary700,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    EverwellFigmaMcpRasterAssets.healthE2Heart,
                    width: 14,
                    height: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(record.measuredAt),
                      style: EverwellFigmaText.interSemi(32 / 2),
                    ),
                    Text(
                      _formatTime(record.measuredAt),
                      style: EverwellFigmaText.interRegular(
                        14,
                        color: const Color(0xFF6E6E6E),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${record.bpm}',
                    style: EverwellFigmaText.interBold(
                      32 / 2,
                      color: const Color(0xFF1E76FF),
                    ),
                  ),
                  Text(
                    'BPM',
                    style: EverwellFigmaText.interRegular(
                      13,
                      color: const Color(0xFF6E6E6E),
                    ),
                  ),
                  Text(
                    status,
                    style: EverwellFigmaText.quicksandMedium(
                      14,
                      color: const Color(0xFF6E6E6E),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (record.bpm / 120).clamp(0.1, 1.0),
            minHeight: 5,
            borderRadius: BorderRadius.circular(999),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E76FF)),
            backgroundColor: const Color(0xFFE5E7EB),
          ),
        ],
      ),
    );
  }
}

String _formatDateUs(DateTime date) {
  final mm = date.month.toString().padLeft(2, '0');
  final dd = date.day.toString().padLeft(2, '0');
  return '$mm/$dd/${date.year}';
}

String _formatDate(DateTime date) {
  final dd = date.day.toString().padLeft(2, '0');
  final mm = date.month.toString().padLeft(2, '0');
  final yyyy = date.year.toString();
  return '$dd/$mm/$yyyy';
}

String _formatTime(DateTime date) {
  final h = date.hour.toString().padLeft(2, '0');
  final m = date.minute.toString().padLeft(2, '0');
  final suffix = date.hour >= 12 ? 'PM' : 'AM';
  return '$h:$m $suffix';
}
