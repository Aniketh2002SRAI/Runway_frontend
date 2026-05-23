import 'package:flutter/material.dart';
import 'package:runway/core/routing/service/navigation_service.dart';
import 'package:runway/core/theme/app_theme.dart';
import 'package:runway/core/theme/theme_service.dart';
import 'package:runway/di/dependencies/dependencies.dart';
import 'package:runway/di/service_locator/service_locator.dart';
import 'package:runway/l10n/app_localizations.dart';
import 'package:runway/core/l10n/l10n_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const RunwayApp());
}

class RunwayApp extends StatefulWidget {
  const RunwayApp({super.key});

  @override
  State<RunwayApp> createState() => _RunwayAppState();
}

class _RunwayAppState extends State<RunwayApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [...AppLocalizations.localizationsDelegates],
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'A job platform app',
      routerConfig: sl<NavigationService>().router,
      themeMode: ThemeMode.system,
      builder: (context, child) {
        _intServices(context: context);
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }

  void _intServices({required BuildContext context}) {
    final l10n = AppLocalizations.of(context);
    if (l10n != null) {
      sl<L10nService>().setL10n(l10n);
    }
    final theme = Theme.of(context).extension<AppTheme>()!;
    sl<ThemeService>().setTheme(theme);
  }
}
