import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raxii/app/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final textTheme = ThemeData.light().textTheme;

    return ThemeData(
      useMaterial3: true,
      textTheme: textTheme.apply(
        bodyColor: AppColors.deepForestGreen,
        displayColor: AppColors.deepForestGreen,
        fontFamily: 'Inter',
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          fontFamily: 'Inter',
        ),
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.softGray,
        indicatorColor: AppColors.primary,
        labelStyle: textTheme.labelLarge?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        unselectedLabelStyle: textTheme.labelLarge?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: textTheme.bodyLarge?.copyWith(
          fontSize: 18,
          color: AppColors.deepForestGreen,
          fontFamily: 'Inter',
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          fontSize: 18,
          color: AppColors.softGray,
          fontFamily: 'Inter',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.softGray.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.softGray.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        filled: true,
        fillColor: AppColors.softGray.withOpacity(0.1),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          textStyle: textTheme.labelLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: textTheme.labelLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColors.primary,
      ),
    );
  }
}
