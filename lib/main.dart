import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:compairifuel/src/app.dart';

void main() async {
  await dotenv.load();
  runApp(const ProviderScope(child: MyApp2()));
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  static const String _title = 'Flutter Stateful Clicker Counter';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state.
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
        color: Colors.white,
        child: Center(
          child: SizedBox(height: 201,width: 366,child: Card(),),
        ));
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFF9E9E9E),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      // width: 366,
      // height: 201,
      child: const Padding(
        padding: EdgeInsets.all(13.0),
        child: Column(
          children: [
            CardHeader(),
            CardSubTitle(),
            CardActionButtons(),
            CardFuelPrices(),
            CardFooter()
          ],
        ),
      ),
    );
  }
}

class CardFuelPrices extends StatelessWidget {
  const CardFuelPrices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Divider(
          key: Key('horizontal_divider_1'),
          height: 5,
          thickness: 0.5,
          color: Color(0xFF9E9E9E),
        ),
        IntrinsicHeight(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'E10',
                      style: TextStyle(
                        color: Color(
                            0xFF1D1B20) /* Schemes-On-Surface */,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                        letterSpacing: 0.10,
                      ),
                    ),
                    Text(
                      '\$ 1,987',
                      style: TextStyle(
                        color: Color(
                            0xFF49454F) /* Schemes-On-Surface-Variant */,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                        letterSpacing: 0.40,
                      ),
                    ),
                  ],
                ),
                VerticalDivider(
                  key: Key('vertical_divider_1'),
                  thickness: 0.5,
                  width: 10,
                  color: Color(0xFF9E9EDD),
                ),
                Column(
                  children: [
                    Text(
                      'E85',
                      style: TextStyle(
                        color: Color(
                            0xFF1D1B20) /* Schemes-On-Surface */,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                        letterSpacing: 0.10,
                      ),
                    ),
                    Text(
                      '\$ 1,987',
                      style: TextStyle(
                        color: Color(
                            0xFF49454F) /* Schemes-On-Surface-Variant */,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                        letterSpacing: 0.40,
                      ),
                    ),
                  ],
                ),
                VerticalDivider(
                  key: Key('vertical_divider_2'),
                  width: 10,
                  thickness: 0.5,
                  color: Color(0xFF9E9E9E),
                ),
                Column(
                  children: [
                    Text(
                      'E5',
                      style: TextStyle(
                        color: Color(
                            0xFF1D1B20) /* Schemes-On-Surface */,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                        letterSpacing: 0.10,
                      ),
                    ),
                    Text(
                      '\$ 1,987',
                      style: TextStyle(
                        color: Color(
                            0xFF49454F) /* Schemes-On-Surface-Variant */,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                        letterSpacing: 0.40,
                      ),
                    ),
                  ],
                ),
              ]),
        ),
        Divider(
          key: Key('horizontal_divider_2'),
          thickness: 0.5,
          height: 5,
          color: Color(0xFF9E9E9E),
        ),
      ],
    );
  }
}

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Xenos',
            style: TextStyle(
              color: Color(0xFF212121),
              fontSize: 20,
              fontFamily: 'Avenir',
              fontWeight: FontWeight.w800,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '4.6 ',
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 14,
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '(40)',
                  style: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 14,
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

class CardSubTitle extends StatelessWidget {
  const CardSubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(spacing: 12, children: [
        Text(
          'Store',
          style: TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 16,
            fontFamily: 'Avenir',
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          '12 min',
          style: TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 16,
            fontFamily: 'Avenir',
            fontWeight: FontWeight.w300,
          ),
        ),
      ]),
    );
  }
}

class CardActionButtons extends StatelessWidget {
  const CardActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        spacing: 8,
        children: [
          Padding(
              padding: const EdgeInsets.all(0),
              // padding: const EdgeInsets.symmetric(
              //     horizontal: 12, vertical: 9),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color(0xFF40577A)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                  ),
                ),
                child: const Text(
                  'Directions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onPressed: () => {},
              )),
          Padding(
              padding: const EdgeInsets.all(0),
              // padding: const EdgeInsets.symmetric(
              //     horizontal: 12, vertical: 9),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color(0xFF40577A)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                  ),
                ),
                child: const Text(
                  'Website',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onPressed: () => {},
              )),
        ],
      ),
    );
  }
}

class CardFooter extends StatelessWidget {
  const CardFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
          padding: EdgeInsets.only(top: 12),
          child: Row(
            children: [
              Text(
                'Straatnaam, 1, 1234AB, Arnhem',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 16,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        );
  }
}
