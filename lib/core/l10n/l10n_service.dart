import 'package:runway/l10n/app_localizations.dart';

class L10nService {
  late AppLocalizations _l10n;

  void setL10n(AppLocalizations l10n) {
    _l10n = l10n;
  }

  AppLocalizations get l10n => _l10n;
}
