import 'package:flutter/material.dart';
import 'package:compairifuel/src/global/theme/theme.dart';
import 'package:compairifuel/src/routers.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = goRouter();

    return MaterialApp.router(
      theme: getTheme(context),
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale("nl", "NL"),
      supportedLocales: const [Locale("nl", "NL")],
    );
  }
}
