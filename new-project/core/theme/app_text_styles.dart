import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Font family constants
  static const String _primaryFontFamily = 'Roboto';
  static const String _secondaryFontFamily = 'Arial';

  // Get responsive font size with ScreenUtil
  static double _getResponsiveFontSize(double fontSize) {
    return fontSize.sp;
  }

  // Get responsive spacing
  static double _getLetterSpacing(double fontSize) {
    return (fontSize * 0.01).w;
  }

  // Headlines
  static TextStyle get headline1 => TextStyle(
    fontSize: _getResponsiveFontSize(32),
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.2,
    letterSpacing: _getLetterSpacing(32),
  );

  static TextStyle get headline2 => TextStyle(
    fontSize: _getResponsiveFontSize(24),
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.3,
    letterSpacing: _getLetterSpacing(24),
  );

  static TextStyle get headline3 => TextStyle(
    fontSize: _getResponsiveFontSize(20),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.3,
    letterSpacing: _getLetterSpacing(20),
  );

  static TextStyle get headline4 => TextStyle(
    fontSize: _getResponsiveFontSize(18),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(18),
  );

  static TextStyle get headline5 => TextStyle(
    fontSize: _getResponsiveFontSize(16),
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(16),
  );

  static TextStyle get headline6 => TextStyle(
    fontSize: _getResponsiveFontSize(14),
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(14),
  );

  // Body text
  static TextStyle get bodyText1 => TextStyle(
    fontSize: _getResponsiveFontSize(16),
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.5,
    letterSpacing: _getLetterSpacing(16),
  );

  static TextStyle get bodyText2 => TextStyle(
    fontSize: _getResponsiveFontSize(14),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: _primaryFontFamily,
    height: 1.5,
    letterSpacing: _getLetterSpacing(14),
  );

  static TextStyle get bodyText3 => TextStyle(
    fontSize: _getResponsiveFontSize(12),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: _primaryFontFamily,
    height: 1.5,
    letterSpacing: _getLetterSpacing(12),
  );

  // Subtitle styles
  static TextStyle get subtitle1 => TextStyle(
    fontSize: _getResponsiveFontSize(16),
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(16),
  );

  static TextStyle get subtitle2 => TextStyle(
    fontSize: _getResponsiveFontSize(14),
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(14),
  );

  // Caption and small text
  static TextStyle get caption => TextStyle(
    fontSize: _getResponsiveFontSize(12),
    fontWeight: FontWeight.normal,
    color: AppColors.textHint,
    fontFamily: _secondaryFontFamily,
    height: 1.3,
    letterSpacing: _getLetterSpacing(12),
  );

  static TextStyle get overline => TextStyle(
    fontSize: _getResponsiveFontSize(10),
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
    fontFamily: _secondaryFontFamily,
    height: 1.3,
    letterSpacing: (10 * 0.015).w,
  );

  // Button text styles
  static TextStyle get button => TextStyle(
    fontSize: _getResponsiveFontSize(16),
    fontWeight: FontWeight.w600,
    color: AppColors.surface,
    fontFamily: _primaryFontFamily,
    height: 1.2,
    letterSpacing: (16 * 0.012).w,
  );

  static TextStyle get buttonLarge => TextStyle(
    fontSize: _getResponsiveFontSize(18),
    fontWeight: FontWeight.w600,
    color: AppColors.surface,
    fontFamily: _primaryFontFamily,
    height: 1.2,
    letterSpacing: (18 * 0.012).w,
  );

  static TextStyle get buttonSmall => TextStyle(
    fontSize: _getResponsiveFontSize(14),
    fontWeight: FontWeight.w500,
    color: AppColors.surface,
    fontFamily: _primaryFontFamily,
    height: 1.2,
    letterSpacing: (14 * 0.011).w,
  );

  // Specialized text styles
  static TextStyle get errorText => TextStyle(
    fontSize: _getResponsiveFontSize(12),
    fontWeight: FontWeight.normal,
    color: Colors.red,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(12),
  );

  static TextStyle get successText => TextStyle(
    fontSize: _getResponsiveFontSize(12),
    fontWeight: FontWeight.normal,
    color: Colors.green,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(12),
  );

  static TextStyle get warningText => TextStyle(
    fontSize: _getResponsiveFontSize(12),
    fontWeight: FontWeight.normal,
    color: Colors.orange,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(12),
  );

  static TextStyle get linkText => TextStyle(
    fontSize: _getResponsiveFontSize(16),
    fontWeight: FontWeight.w500,
    color: Colors.blue,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(16),
    decoration: TextDecoration.underline,
  );

  // Input field text styles
  static TextStyle get inputText => TextStyle(
    fontSize: _getResponsiveFontSize(16),
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(16),
  );

  static TextStyle get inputLabel => TextStyle(
    fontSize: _getResponsiveFontSize(14),
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(14),
  );

  static TextStyle get inputHint => TextStyle(
    fontSize: _getResponsiveFontSize(16),
    fontWeight: FontWeight.normal,
    color: AppColors.textHint,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(16),
  );

  // Utility methods for custom styling
  static TextStyle customStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    String? fontFamily,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    final responsiveFontSize =
        fontSize != null
            ? _getResponsiveFontSize(fontSize)
            : _getResponsiveFontSize(16);

    return TextStyle(
      fontSize: responsiveFontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.textPrimary,
      fontFamily: fontFamily ?? _primaryFontFamily,
      height: height ?? 1.4,
      letterSpacing: letterSpacing ?? _getLetterSpacing(fontSize ?? 16),
      decoration: decoration,
    );
  }

  // Method to get text style with color variation
  static TextStyle withColor(TextStyle baseStyle, Color color) {
    return baseStyle.copyWith(color: color);
  }

  // Method to get text style with weight variation
  static TextStyle withWeight(TextStyle baseStyle, FontWeight weight) {
    return baseStyle.copyWith(fontWeight: weight);
  }

  // Method to get text style with size variation
  static TextStyle withSize(TextStyle baseStyle, double fontSize) {
    return baseStyle.copyWith(fontSize: _getResponsiveFontSize(fontSize));
  }

  // App bar text styles
  static TextStyle get appBarTitle => TextStyle(
    fontSize: _getResponsiveFontSize(20),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.2,
    letterSpacing: _getLetterSpacing(20),
  );

  static TextStyle get appBarSubtitle => TextStyle(
    fontSize: _getResponsiveFontSize(14),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: _primaryFontFamily,
    height: 1.3,
    letterSpacing: _getLetterSpacing(14),
  );

  // Tab bar text styles
  static TextStyle get tabLabel => TextStyle(
    fontSize: _getResponsiveFontSize(14),
    fontWeight: FontWeight.w500,
    fontFamily: _primaryFontFamily,
    height: 1.2,
    letterSpacing: _getLetterSpacing(14),
  );

  // Card text styles
  static TextStyle get cardTitle => TextStyle(
    fontSize: _getResponsiveFontSize(18),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.3,
    letterSpacing: _getLetterSpacing(18),
  );

  static TextStyle get cardSubtitle => TextStyle(
    fontSize: _getResponsiveFontSize(14),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(14),
  );

  // List tile text styles
  static TextStyle get listTitle => TextStyle(
    fontSize: _getResponsiveFontSize(16),
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: _primaryFontFamily,
    height: 1.3,
    letterSpacing: _getLetterSpacing(16),
  );

  static TextStyle get listSubtitle => TextStyle(
    fontSize: _getResponsiveFontSize(14),
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: _primaryFontFamily,
    height: 1.4,
    letterSpacing: _getLetterSpacing(14),
  );
}
