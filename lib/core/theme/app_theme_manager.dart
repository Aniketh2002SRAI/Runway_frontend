import 'package:flutter/material.dart';
import 'package:runway/core/theme/app_theme.dart';
import 'package:runway/core/theme/color_tokens.dart';

class AppThemeManager {
  AppThemeManager._();

  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorTokens.white100,
    elevatedButtonTheme: _lightBtnTheme(),
    inputDecorationTheme: _lightTextFieldTheme(),
    extensions: [
      const AppTheme(
        surfaceColor: ColorTokens.white,
        surfaceBorderColor: ColorTokens.black,
        commonOnSurfaceColor: ColorTokens.white100,
      ),
    ],
  );

  static ElevatedButtonThemeData _lightBtnTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        iconColor: ColorTokens.white,
        backgroundColor: ColorTokens.black,
        foregroundColor: ColorTokens.white,
        disabledBackgroundColor: ColorTokens.white100,
        disabledIconColor: ColorTokens.black,
        disabledForegroundColor: ColorTokens.black,
        iconAlignment: IconAlignment.end,
        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static InputDecorationTheme _lightTextFieldTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: ColorTokens.white100,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),

      prefixStyle: TextStyle(
        color: ColorTokens.white100,
        fontSize: 14,
        height: 24 / 18,
        fontWeight: FontWeight.w400,
      ),

      hintStyle: TextStyle(
        color: ColorTokens.white100,
        fontSize: 14,
        height: 1,
        fontWeight: FontWeight.w400,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorTokens.black.withValues(alpha: 0.5)),
      ),

      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorTokens.black.withValues(alpha: 0.5)),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorTokens.green),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorTokens.green, width: 1),
      ),
    );
  }
}
