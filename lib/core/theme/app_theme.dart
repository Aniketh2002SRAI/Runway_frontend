import 'package:flutter/material.dart';
import 'package:theme_extensions_builder_annotation/theme_extensions_builder_annotation.dart';

part 'app_theme.g.theme.dart';

@ThemeExtensions()
class AppTheme extends ThemeExtension<AppTheme> with _$AppTheme {
  const AppTheme({
    required this.surfaceColor,
    required this.surfaceBorderColor,
    required this.commonOnSurfaceColor,
  });

  final Color surfaceColor;
  final Color surfaceBorderColor;
  final Color commonOnSurfaceColor;
}
