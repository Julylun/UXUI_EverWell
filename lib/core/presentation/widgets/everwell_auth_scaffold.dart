import 'package:flutter/material.dart';

import 'everwell_auth_background.dart';
import 'everwell_glass_panel.dart';

/// Full-screen WS-A layout: abstract background + header + bottom glass panel.
class EverwellAuthScaffold extends StatelessWidget {
  const EverwellAuthScaffold({
    super.key,
    required this.panel,
    this.maxPanelHeightFraction = 0.72,
  });

  final Widget panel;
  final double maxPanelHeightFraction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const EverwellAuthBackground(),
          Column(
            children: [
              const EverwellAuthHeader(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: EverwellGlassPanel(
                    maxHeightFraction: maxPanelHeightFraction,
                    child: panel,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
