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
        colorScheme:
          ColorScheme.fromSeed(seedColor: Colors.blue),
          // ColorScheme(),
        useMaterial3: true,
      ),
      home: page,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int index = 0;
//
//   final List<Widget> pages = [
//     const MapPage(title: 'Map'),
//     const UserManualPage(title: 'User manual'),
//   ];
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xFF004c97),
//         currentIndex: index,
//         onTap: (int index) => setState(() => this.index = index),
//         items: [
//           BottomNavigationBarItem(
//             icon: Image.asset("assets/images/map.png", width: 35, height: 35),
//             label: 'Map',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset("assets/images/questions.png",
//                 width: 35, height: 35),
//             label: 'Manual',
//           )
//         ],
//       ),
//       body: IndexedStack(
//         index: index,
//         children: pages,
//       ),
//     );
//   }
// }

// TODO Refactor Data Code Parts
