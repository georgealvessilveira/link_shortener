import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:link_shortener/modules/home/controllers/home.dart';
import 'package:link_shortener/modules/home/screens/home.dart';
import 'package:link_shortener/modules/link/repositories/link.dart';
import 'package:localization/localization.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return MaterialApp(
      title: 'Link Shortener',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 26.0),
        ),
      ),
      localizationsDelegates: [
        LocalJsonLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      home: BlocProvider(
        create: (_) => HomeController(
          linkRepository: YourlsLinkRepository(),
        ),
        child: const HomeScreen(),
      ),
    );
  }
}
