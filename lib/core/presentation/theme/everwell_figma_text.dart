import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography gần Figma (Quicksand / Inter) — WS-B/C MCP `get_design_context`.
abstract final class EverwellFigmaText {
  static TextStyle quicksandSemi(double size, {Color? color, double? height}) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w600,
      height: height,
      color: color,
    );
  }

  static TextStyle quicksandRegular(double size, {Color? color}) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle quicksandMedium(double size, {Color? color}) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle interBold(double size, {Color? color, double? height}) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: FontWeight.w700,
      height: height,
      color: color,
    );
  }

  static TextStyle interSemi(double size, {Color? color, double? height}) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: FontWeight.w600,
      height: height,
      color: color,
    );
  }

  static TextStyle interMedium(double size, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle interRegular(double size, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle manropeBold(double size, {Color? color}) {
    return GoogleFonts.manrope(
      fontSize: size,
      fontWeight: FontWeight.w700,
      height: 28 / 20,
      color: color,
    );
  }
}
