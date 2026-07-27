import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // main background color (soft off-white)
  static const background = Color(0xFFF8F7FC);

  // purple accent used for selected items, buttons
  static const primary = Color(0xFF8B7CF6);
  static const primaryLight = Color(0xFFB8A6F5);

  // card colors
  static const cardWhite = Color(0xFFFFFFFF);

  // text colors
  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF8E8E9A);

  // colors for different habit icon circles (used randomly per habit)
  static const iconBlue = Color(0xFFDCEBFB);
  static const iconPink = Color(0xFFFBE1E1);
  static const iconPurple = Color(0xFFEDE7FB);
  static const iconGreen = Color(0xFFE3F5E1);
}

class AppTextStyles {
  static TextStyle heading = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle subheading = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle cardTitle = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle cardSubtitle = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}
