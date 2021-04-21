import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shortcut_comics/main.dart' as app;
import 'package:shortcut_comics/widgets/rounded_button.dart';

///To run flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/search_text_error_test.dart
void main() {
  /// Search with wrong input
  /// Want to se if the user type in something wrong
  /// the the user get some information about the wrong input
  group('Search with wrong input', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("test search with wrong input", (tester) async {
      app.main(); // start app
      await tester.pumpAndSettle(); // this means wait
      final searchIdComics = find.byKey(Key('searchText')); // find button on screen
      await tester.tap(searchIdComics);
      await tester.pumpAndSettle();
      final searchField = find.byType(TextFormField).first; // find TextFormField
      final searchButton = find.byType(RoundedButton).first; // find Button
      await tester.enterText(searchField, 'test123'); // enter a wrong value
      await tester.pumpAndSettle();
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      final inputErrorFinder = find.text('Only one word and only letters'); // find info text
      expect(tester.getSemantics(inputErrorFinder).label, 'Only one word and only letters');
    });
  });
}