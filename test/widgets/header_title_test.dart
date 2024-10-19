import 'package:compairifuel/src/global/ui/widgets/header_title.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('HeaderTitle has a title', (WidgetTester tester) async {
    var identifier = 'Usermanual';
    var widget = HeaderTitle(text: identifier);

    await tester.pumpWidgetInEnv(widget);
    final titleFinder = find.text(identifier);

    expect(titleFinder, findsOneWidget);
    expect(find.byWidget(widget), findsOneWidget);
  });
}
