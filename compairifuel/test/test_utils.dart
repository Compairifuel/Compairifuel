import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

Future<void> pumpWidgetInEnv(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
    home: widget,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: const [Locale("nl", "NL")],
  )));
}
