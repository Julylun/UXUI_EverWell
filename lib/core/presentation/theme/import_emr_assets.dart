import 'package:flutter/material.dart';

/// Logo ô nhập nguồn — tải từ Figma MCP `get_design_context` (node `806:4719`),
/// file `vnowI58w60vDikzzDSaex5`.
abstract final class ImportEmrAssets {
  static const vneidTile = 'assets/images/import_emr/vneid_tile.png';
  static const govTile = 'assets/images/import_emr/gov_tile.png';
  static const choRayTile = 'assets/images/import_emr/cho_ray_tile.png';

  static String? tilePathForSource(String? source) => switch (source) {
        'VNEID' => vneidTile,
        'GOV' => govTile,
        'CHO_RAY' => choRayTile,
        _ => null,
      };

  /// Nền ô logo theo Figma (VNEID đỏ #EB0000; GOV / Chợ Rẫy nền trắng).
  static Color tileBackdropForSource(String? source) => switch (source) {
        'VNEID' => const Color(0xFFEB0000),
        _ => Colors.white,
      };
}
