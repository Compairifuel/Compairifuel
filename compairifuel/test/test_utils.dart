import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class EnvWidget extends StatelessWidget {
  final Widget child;

  const EnvWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [Locale("nl", "NL")],
      ),
    );
  }
}

extension PumpWidgetInEnv on WidgetTester {
  Future<void> pumpWidgetInEnv(Widget widget) async {
    await pumpWidget(EnvWidget(child: widget));
  }
}
