import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/everwell_figma_mcp_raster_assets.dart';

/// Tab bar 5 nút tròn — khớp Figma WS-B/C (nền `primary50`, giữa active `primary900`).
class EverwellBottomTabBar extends StatelessWidget {
  const EverwellBottomTabBar({
    super.key,
    this.activeIndex = 2,
    this.tabAssets = EverwellTabMcpAssets.homeScreen,
    this.onHome,
    this.onSearch,
    this.onGrid,
    this.onProfile,
    this.onSettings,
  });

  final int activeIndex;
  /// Raster MCP theo màn (B1 vs C1/C2/C4 dùng URL export khác nhau).
  final EverwellTabMcpAssets tabAssets;
  final VoidCallback? onHome;
  final VoidCallback? onSearch;
  final VoidCallback? onGrid;
  final VoidCallback? onProfile;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary50,
      elevation: 0,
      shadowColor: const Color(0x291F4D73),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _circle(0, tabAssets.home, onHome),
            _circle(1, tabAssets.search, onSearch),
            _circle(2, tabAssets.grid, onGrid),
            _circle(3, tabAssets.records, onProfile),
            _circle(4, tabAssets.profile, onSettings),
          ],
        ),
      ),
    );
  }

  Widget _circle(int index, String assetPath, VoidCallback? onTap) {
    final active = index == activeIndex;
    return Material(
      color: active ? AppColors.primary900 : AppColors.primary100,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset(
            assetPath,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
          ),
        ),
      ),
    );
  }
}
