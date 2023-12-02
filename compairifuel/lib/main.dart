import 'package:compairifuel/pages/usermanual.dart';
import 'package:compairifuel/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:compairifuel/pages/map.dart';

void main() {
  runApp(const MyApp());
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const MapPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

   final List<Widget> pages = [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Map'),
        ],
      ),
    ),
     Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Text('Settings'),
         ],
       ),
     ),
     UserManualPage(title: 'User manual'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        currentIndex: index,
        onTap: (int index) => setState(() => this.index = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Manual',
          ),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: pages,
      ),
    );
  }
}
//Image.asset("assets/images/questions.png")
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         currentIndex: index,
//         onTap: (int index) => setState(() => this.index = index),
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map),
//             label: 'map',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'settings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.info),
//             label: 'settings',
//           ),
//         ],
//       ),
//       body: IndexedStack(
//         index: index,
//         children: pages,
//       ),
//  List<Widget> pages = [];
//   void changeActivePage(int index) {
//     setState(() {
//       currentPageIndex = index;
//     });
//   }
//   @override
//   void initState() {
//     pages = [
//       const UserManualPage(title: 'User manual'),
//     ];
//     super.initState();
//   }
