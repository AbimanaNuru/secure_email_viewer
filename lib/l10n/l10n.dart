import 'package:flutter/widgets.dart';
import 'package:secure_email_viewer/l10n/gen/app_localizations.dart';

export 'package:secure_email_viewer/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
