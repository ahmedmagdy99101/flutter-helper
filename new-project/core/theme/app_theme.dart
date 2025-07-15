import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTheme {
  static const String fontFamily = 'Cairo';

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    useMaterial3: true,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.textHint,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      background: Colors.white,
      // خلفية التطبيق
      onBackground: Colors.black,
      // لون النص على الخلفية
      surface: Colors.white,
      // سطح البطاقات والنوافذ
      onSurface: Colors.black,
      // لون النص على السطح
      error: Colors.red,
      // لون الخطأ
      onError: Colors.white, // لون النص على الخطأ
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primary,
      selectionHandleColor: AppColors.primary,
    ),
    fontFamily: fontFamily,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
        // backgroundColor: primaryColor, // لون النص في TextButton
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xffffffff),
      contentPadding: const EdgeInsets.all(14.0),
      isDense: true,
      hintStyle: const TextStyle(color: Color(0xff9E9E9E)),
      labelStyle: const TextStyle(color: Color(0xff9E9E9E)),
      focusColor: AppColors.primary,
      floatingLabelStyle: const TextStyle(
        color: AppColors.primary,
        fontSize: 18,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Color(0xffDBDBDB)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xffDBDBDB), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: AppColors.primary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.primary),
        foregroundColor: WidgetStateProperty.all<Color>(
          Colors.white,
        ), // لون النص في ElevatedButton
        overlayColor: WidgetStateProperty.all<Color>(Colors.black26),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFFF6F6F6),
    ),
  );

  // تعريف الثيم الداكن (Dark Theme)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryDark,
      selectionColor: AppColors.primaryDark,
      selectionHandleColor: AppColors.primaryDark,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E), // لون البطاقات في Dark Mode
      shadowColor: Colors.black.withOpacity(0.5), // ظل البطاقات
      elevation: 4, // ارتفاع الظل
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // زوايا البطاقة
      ),
    ),
    fontFamily: fontFamily,
    scaffoldBackgroundColor: const Color(0xFF222222),
    // خلفية التطبيق في Dark Mode
    primaryColor: AppColors.primaryDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark,
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      background: const Color(0xFF121212),
      // خلفية التطبيق
      onBackground: Colors.white,
      // لون النص على الخلفية
      surface: const Color(0xFF1E1E1E),
      // سطح البطاقات والنوافذ
      onSurface: Colors.white,
      // لون النص على السطح
      error: const Color(0xFFCF6679),
      // لون الخطأ
      onError: Colors.black, // لون النص على الخطأ
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.all<Color>(Colors.grey),
      thumbColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.primaryDark),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      focusColor: AppColors.primaryDark,
      floatingLabelStyle: const TextStyle(
        color: AppColors.primaryDark,
        fontSize: 25,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.primaryDark, // لون الحدود في الثيم الداكن
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: AppColors.primaryDark),
        borderRadius: BorderRadius.circular(15.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(15.0),
      ),
      fillColor: const Color(0xFF333333),
      // لون خلفية الحقول في Dark Mode
      filled: true,
      hintStyle: const TextStyle(color: Color(0xff9E9E9E)),
      labelStyle: const TextStyle(color: Color(0xff9E9E9E)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.primaryDark),
        foregroundColor: WidgetStateProperty.all<Color>(
          Colors.white,
        ), // لون النص في ElevatedButton
        overlayColor: WidgetStateProperty.all<Color>(Colors.black26),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF333333), // لون الـ BottomSheet في Dark Mode
    ),
  );
}
