import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/i18n/utils/i18n.dart';
import 'package:link_shortener/modules/link/components/link_alias.dart';
import 'package:link_shortener/modules/link/models/link_alias.dart';

void main() async {
  testWidgets('Check link alias values in widget test', (WidgetTester tester) async {
    const linkAlias = LinkAlias(
      alias: 'alias',
      originalUrl: 'originalUrl',
      shortUrl: 'shortUrl',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: LinkAliasView(linkAlias: linkAlias),
      ),
    );

    expect(find.text(linkAlias.alias), findsOneWidget);
    expect(
      find.text(I18N.linkAliasShortUrl(linkAlias.shortUrl)),
      findsOneWidget,
    );
    expect(
      find.text(I18N.linkAliasOriginalUrl(linkAlias.originalUrl)),
      findsOneWidget,
    );
  });

  testWidgets('Check title in list of links in widget test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LinkAliasListView(links: []),
      ),
    );

    expect(find.text(I18N.titleRecentlyUrls()), findsOneWidget);
  });
}
