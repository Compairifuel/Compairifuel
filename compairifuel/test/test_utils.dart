import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpWidgetInEnv(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(ProviderScope(child:MaterialApp(home:widget)));
}
