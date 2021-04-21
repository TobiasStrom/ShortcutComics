import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shortcut_comics/main.dart' as app;
import 'package:shortcut_comics/widgets/rounded_button.dart';

///To run: flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/search_text_test.dart
void main() {
  /// Search by test
  /// Want to se if the user want to search for comics with text
  /// it go to the right screen
  group('Search by test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("test search ", (tester) async {
      app.main(); // start app
      await tester.pumpAndSettle(); // this means wait
      final searchIdComics = find.byKey(Key('searchText')); // find button on screen
      await tester.tap(searchIdComics); // navigate to SearchTextScreen
      await tester.pumpAndSettle();
      final searchField = find.byType(TextFormField).first; // find input field
      final searchButton = find.byType(RoundedButton).first; // find button

      await tester.enterText(searchField, 'test'); // enter 'test' info field
      await tester.pumpAndSettle();
      await tester.tap(searchButton); // navigate to SearchResultScreen
      await tester.pumpAndSettle();
      final searchResultItem = find.byType(Text).first; // find first text
      expect((tester.getSemantics(searchResultItem)), matchesSemantics(label: 'Results')); // check it title is 'Results'
    });
  });
}