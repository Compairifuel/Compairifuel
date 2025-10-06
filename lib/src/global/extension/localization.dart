import "package:flutter/material.dart";
import "package:compairifuel/localization/app_localizations.dart";

AppLocalizations getLocalizations(BuildContext context) =>
    AppLocalizations.of(context)!;

extension GetLocalizations on BuildContext {
  AppLocalizations localizations() => getLocalizations(this);
}
