import 'package:compairifuel/Page.dart' as PageComponent;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:compairifuel/Map/Map.dart';

import 'Navbar.dart';
import 'Pagination.dart';

void main() async {
  await dotenv.load();

  // [Map(mapMarkerLayer: const [
  //   MapMarkerLayer(
  //       markers: [MapMarker(point: LatLng(11, 11), child: Text(""))])
  // ]),
  //   UserManual(),
  // ],

  var a = PageComponent.Page(
      title: 'Map',
      content: Map(),
      navbar: Navbar(),
      pagination: const Pagination());

  runApp(MyApp(page:a));
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => MyApp(page:a),
    ),
  );
}

mixin child {}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.page});

  // Refactering addition
  final PageComponent.Page page;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
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
        colorScheme: const ColorScheme(
              primary: Color(0xFF004c97),
              onPrimary: Color(0xFF166cc2),
              primaryContainer: Color(0xFF76b1ec),
              onPrimaryContainer: Color(0xFFb9d7f5),
              secondary: Color(0xFF009700),
              onSecondary: Color(0xFF16c21f),
              secondaryContainer: Color(0xFF76ec7c),
              onSecondaryContainer: Color(0xFFb9f5bc),


              brightness: Brightness.light,
              error: Color(0xFF880000),
              onError: Color(0xFFcc0000),
              background: Color(0x00000000),
              onBackground: Color(0x00000000),
              surface: Color(0x00000000),
              onSurface: Color(0x00000000),
          ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize:24,fontWeight: FontWeight.bold,fontFamily: "Roboto",fontFamilyFallback: ["Roboto Serif"]),
          bodyMedium: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,fontFamily: "Roboto",fontFamilyFallback: ["Roboto Serif"]),
          labelMedium: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "Roboto",fontFamilyFallback: ["Roboto Serif"]),
          bodySmall: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,fontFamily: "Roboto",fontFamilyFallback: ["Roboto Serif"]),
        ),
        useMaterial3: false,
      ),
      home: page,
    );
  }
}