import 'package:compairifuel/src/global/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('Logo has an image', (tester) async {
    var identifier = 'assets/images/logo_compairifuel_primary.png';
    var widget = Logo(image: identifier);

    await tester.pumpWidgetInEnv(widget);
    final imageFinder = find.image(AssetImage(identifier));

    expect(imageFinder, findsOneWidget);
    expect(find.byWidget(widget), findsOneWidget);
  });
  testWidgets('Logo has a default image', (tester) async {
    var identifier = 'assets/images/logo_compairifuel_primary.png';
    var widget = const Logo();

    await tester.pumpWidgetInEnv(widget);
    final imageFinder = find.image(AssetImage(identifier));

    expect(imageFinder, findsOneWidget);
    expect(find.byWidget(widget), findsOneWidget);
  });
}
