import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shortcut_comics/main.dart' as app;
import 'package:shortcut_comics/widgets/rounded_button.dart';
///To run: flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/search_id_test.dart

void main() {
  /// Search with id for comics
  /// Want to se if the user want to get the a comics by
  /// it return the right one
  group('Search with id for comics', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("test search ", (tester) async {
      app.main(); // start app
      await tester.pumpAndSettle(); // this means wait
      final searchIdComics = find.byKey(Key('searchId')); // find element on screen
      await tester.tap(searchIdComics); // tap the button
      await tester.pumpAndSettle();
      final searchField = find.byType(TextFormField).first; // find textField on screen
      final searchButton = find.byType(RoundedButton).first; // find button on screen

      await tester.enterText(searchField, '1'); //enter '1' into the field
      await tester.pumpAndSettle();
      await tester.tap(searchButton); // press searchButton
      await tester.pumpAndSettle();
      final titleTextBox = find.byKey(Key('title')); // find element
      expect(tester.getSemantics(titleTextBox), matchesSemantics(label: 'Barrel - Part 1')); // Check if value is right
    });
  });
}