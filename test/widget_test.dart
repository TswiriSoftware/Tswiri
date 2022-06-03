import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: HomeView(),
    );
  }

  testWidgets(
    'Main Screen Tests',
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Sunbird', skipOffstage: false), findsOneWidget);
      expect(find.byKey(const Key('Search')), findsOneWidget);
      expect(find.byKey(const Key('Tags')), findsOneWidget);
      expect(find.byKey(const Key('Gallery')), findsOneWidget);
      expect(find.byKey(const Key('Containers')), findsOneWidget);
    },
  );
}
