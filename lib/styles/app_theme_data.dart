import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppThemeData {
  static AppThemeData? _instance;
  ThemeData? _appTheme;

  factory AppThemeData() {
    return _instance ??= AppThemeData._();
  }

  AppThemeData._() {
    _appTheme = ThemeData(
      fontFamily: GoogleFonts.comicNeue().fontFamily,
      appBarTheme: const AppBarTheme(),
      primaryTextTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w800,
        ),
        displayMedium: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.irradiatedGreenColor,
        ),
      ),
    );
  }

  ThemeData get defaultThemeData => _appTheme!;
}
