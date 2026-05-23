import 'package:runway/core/theme/app_theme.dart';

class ThemeService {
  late AppTheme _theme;

  void setTheme(AppTheme theme) {
    _theme = theme;
  }

  AppTheme get theme => _theme;
}
