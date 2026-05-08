import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poc_server_driven_ui/main.dart';

void main() {
  testWidgets('renderiza o app shell', (WidgetTester tester) async {
    await tester.pumpWidget(const ServerDrivenUiApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
