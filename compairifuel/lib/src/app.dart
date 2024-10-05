import 'package:flutter/material.dart';
import 'package:compairifuel/src/global/theme/theme.dart';
import 'package:compairifuel/src/routers.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = goRouter();

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: getTheme(context).colorScheme,
          textTheme: getTheme(context).textTheme.merge(
                Typography.material2021().white.copyWith(
                      titleMedium: Typography.material2021()
                          .white
                          .titleMedium!
                          .copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                              fontFamilyFallback: ["Roboto Serif"]),
                      bodyMedium: Typography.material2021()
                          .white
                          .bodyMedium!
                          .copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Roboto",
                              fontFamilyFallback: ["Roboto Serif"]),
                      labelMedium: Typography.material2021()
                          .white
                          .labelMedium!
                          .copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                              fontFamilyFallback: ["Roboto Serif"]),
                      bodySmall: Typography.material2021()
                          .white
                          .bodySmall!
                          .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Roboto",
                              fontFamilyFallback: ["Roboto Serif"]),
                    ),
              )),
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale("nl", "NL"),
      supportedLocales: const [Locale("nl", "NL")],
      color: getTheme(context).colorScheme.primary,
    );
  }
}
