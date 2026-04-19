import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/everwell_figma_mcp_raster_assets.dart';
import '../../../../core/presentation/widgets/everwell_bottom_tab_bar.dart';

class MedicationPageScaffold extends StatelessWidget {
  const MedicationPageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.fab,
  });

  final String title;
  final Widget body;
  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 88,
        leadingWidth: 88,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 16, bottom: 16),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Color(0xFFD2EBFF),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: Image.asset(
                EverwellFigmaMcpRasterAssets.medHeaderBackArrow,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: body,
      floatingActionButton: fab,
      bottomNavigationBar: const EverwellBottomTabBar(activeIndex: 2),
    );
  }
}
