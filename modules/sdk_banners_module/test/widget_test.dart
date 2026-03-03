// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sdk_banners_module/main.dart';

void main() {
  testWidgets('Module smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SdkBannersModuleApp());
    // Esperamos a que el async initState configure el fallback, sin usar
    // pumpAndSettle (podría quedar animación activa por loaders).
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 50));
      if (find.text('Banners').evaluate().isNotEmpty) break;
    }

    expect(find.byType(MaterialApp), findsOneWidget);
    // En modo test (sin host), se usa fallback y muestra la pantalla contenedora.
    expect(find.text('Banners'), findsOneWidget);
  });
}
