import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shortcut_comics/main.dart' as app;
import 'package:shortcut_comics/screens/search_result_screen.dart';
import 'package:shortcut_comics/widgets/rounded_button.dart';
import 'package:shortcut_comics/widgets/search_result_item.dart';
///To run
///flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/search_text_test.dart
void main() {
  // Test search functionality
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("test search ", (tester) async {
      app.main(); // start app
      await tester.pumpAndSettle();
      final searchIdComics = find.byKey(Key('searchText'));
      await tester.tap(searchIdComics);
      await tester.pumpAndSettle();
      final searchField = find.byType(TextFormField).first;
      final searchButton = find.byType(RoundedButton).first;

      await tester.enterText(searchField, 'test');
      await tester.pumpAndSettle();
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      final searchResultItem = find.byType(Text).first;
      expect((tester.getSemantics(searchResultItem)), matchesSemantics(label: 'Results'));
    });
  });
}