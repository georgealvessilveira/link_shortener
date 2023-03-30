import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/i18n/utils/i18n.dart';
import 'package:link_shortener/modules/home/components/messages.dart';

void main() async {
  testWidgets('Check link alias values in widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NoShortenedLinkMessage(),
      ),
    );

    expect(
      find.text(I18N.noShortenedLink()),
      findsOneWidget,
    );
    expect(
      find.text(I18N.searchAgain()),
      findsOneWidget,
    );
  });
}
