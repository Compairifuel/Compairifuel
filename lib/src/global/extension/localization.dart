import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

AppLocalizations getLocalizations(BuildContext context) =>
    AppLocalizations.of(context)!;

extension GetLocalizations on BuildContext {
  AppLocalizations localizations() => getLocalizations(this);
}
