import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/main.dart';
import 'package:link_shortener/modules/home/components/buttons.dart';
import 'package:link_shortener/modules/home/controllers/home.dart';
import 'package:link_shortener/modules/home/screens/home.dart';
import 'package:link_shortener/modules/link/repositories/link.dart';

void main() {
  testWidgets('Build search appbar test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => HomeController(
              linkRepository: YourlsLinkRepository(),
            ),
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(SendButton), findsOneWidget);
    });
  });
}
