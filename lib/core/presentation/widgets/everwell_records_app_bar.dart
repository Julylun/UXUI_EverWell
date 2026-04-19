import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../theme/everwell_figma_mcp_raster_assets.dart';
import '../theme/everwell_figma_text.dart';
import '../theme/figma_tokens.dart';

/// Header Figma C1/C2/C4 — avatar tròn, tiêu đề giữa, nút back overlay.
class EverwellRecordsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EverwellRecordsAppBar({
    super.key,
    required this.title,
    this.bottomHeight = 0,
    this.headerCircleAsset = EverwellFigmaMcpRasterAssets.mrC1HeaderCircle,
    this.backArrowAsset = EverwellFigmaMcpRasterAssets.mrC1BackArrow,
  });

  final String title;
  final double bottomHeight;
  final String headerCircleAsset;
  final String backArrowAsset;

  @override
  Size get preferredSize => Size.fromHeight(88 + bottomHeight);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 88,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 56,
                  height: 56,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          headerCircleAsset,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                      Positioned(
                        left: 3,
                        top: 5,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => context.pop(),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.asset(
                                backArrowAsset,
                                width: 22,
                                height: 22,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.medium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: EverwellFigmaText.quicksandSemi(
                      20,
                      color: FigmaTokens.black,
                    ),
                  ),
                ),
                const SizedBox(width: 56),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
