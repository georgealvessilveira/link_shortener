import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_shortener/i18n/utils/i18n.dart';
import 'package:link_shortener/modules/home/controllers/home.dart';

class NoShortenedLinkMessage extends StatefulWidget {
  const NoShortenedLinkMessage({Key? key}) : super(key: key);

  @override
  State<NoShortenedLinkMessage> createState() => _NoShortenedLinkMessageState();
}

class _NoShortenedLinkMessageState extends State<NoShortenedLinkMessage> {
  late final homeController = BlocProvider.of<HomeController>(context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              I18N.noShortenedLink(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              child: Text(I18N.searchAgain()),
              onPressed: () => homeController.fetchRecentlyLinks(),
            )
          ],
        ),
      ),
    );
  }
}
