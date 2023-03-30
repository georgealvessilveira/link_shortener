import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_shortener/i18n/utils/i18n.dart';
import 'package:link_shortener/modules/home/components/buttons.dart';
import 'package:link_shortener/modules/home/components/messages.dart';
import 'package:link_shortener/modules/home/controllers/home.dart';
import 'package:link_shortener/modules/link/components/link_alias.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textEditingController = TextEditingController();
  late final homeController = BlocProvider.of<HomeController>(context);

  @override
  void initState() {
    super.initState();
    homeController.fetchRecentlyLinks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(I18N.errorGeneratingUrl()),
              elevation: 2.0,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 68.0,
          title: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: I18N.typeLinkShorten(),
            ),
          ),
          actions: [
            SendButton(
              textEditingController: textEditingController,
              onPressed: _shortenUrlAndClearTextField,
            ),
          ],
        ),
        body: BlocBuilder<HomeController, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == HomeStatus.loaded || state.links.isNotEmpty) {
              return LinkAliasListView(links: state.links);
            }

            return const NoShortenedLinkMessage();
          },
        ),
      ),
    );
  }

  void _shortenUrlAndClearTextField() {
    homeController.shortenUrl(textEditingController.text);
    textEditingController.clear();
  }
}
