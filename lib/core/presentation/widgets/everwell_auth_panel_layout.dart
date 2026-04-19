import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Tiêu đề panel chuẩn (28 / bold / primary).
class EverwellAuthPanelTitle extends StatelessWidget {
  const EverwellAuthPanelTitle(
    this.label, {
    super.key,
    this.textAlign = TextAlign.center,
  });

  final String label;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.primary900,
      ),
    );
  }
}

/// [header] cố định trên, [scrollable] cuộn giữa, [footer] cố định dưới (nút / link).
/// [footer] null → không vùng footer (màn không nút dưới).
class EverwellAuthPanelLayout extends StatelessWidget {
  const EverwellAuthPanelLayout({
    super.key,
    required this.header,
    required this.scrollable,
    this.footer,
    this.headerSpacingAfter = 12,
    this.scrollablePadding = const EdgeInsets.only(bottom: 8),
  });

  final Widget header;
  final double headerSpacingAfter;
  final Widget scrollable;
  final EdgeInsets scrollablePadding;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final bottomSafe = MediaQuery.paddingOf(context).bottom;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          SizedBox(height: headerSpacingAfter),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: scrollablePadding,
              child: scrollable,
            ),
          ),
          if (footer != null)
            Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                12,
                0,
                12 + bottomSafe + keyboard,
              ),
              child: footer!,
            ),
        ],
      ),
    );
  }
}
