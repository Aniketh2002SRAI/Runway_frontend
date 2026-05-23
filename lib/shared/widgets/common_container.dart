import 'package:flutter/material.dart';
import 'package:runway/core/theme/theme_service.dart';
import 'package:runway/di/service_locator/service_locator.dart';

class CommonContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  const CommonContainer({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = sl<ThemeService>().theme;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _theme.surfaceColor,
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.all(
          width: 1,
          color: _theme.surfaceBorderColor.withValues(alpha: 0.5),
        ),
      ),
      child: child,
    );
  }
}
