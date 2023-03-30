import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_shortener/i18n/utils/i18n.dart';
import 'package:link_shortener/modules/home/controllers/home.dart';
import 'package:link_shortener/modules/link/models/link_alias.dart';

class LinkAliasView extends StatelessWidget {
  final LinkAlias linkAlias;

  const LinkAliasView({
    Key? key,
    required this.linkAlias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: ListTile(
            title: Text(linkAlias.alias),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18N.linkAliasShortUrl(linkAlias.shortUrl)),
                Text(I18N.linkAliasOriginalUrl(linkAlias.originalUrl)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinkAliasListView extends StatefulWidget {
  final List<LinkAlias> links;

  const LinkAliasListView({
    Key? key,
    required this.links,
  }) : super(key: key);

  @override
  State<LinkAliasListView> createState() => _LinkAliasListViewState();
}

class _LinkAliasListViewState extends State<LinkAliasListView> {
  late final homeController = BlocProvider.of<HomeController>(context);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 16.0,
            ),
            child: Text(
              I18N.titleRecentlyUrls(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: RefreshIndicator(
            onRefresh: () => homeController.fetchRecentlyLinks(),
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.links.length,
              itemBuilder: (BuildContext context, int index) {
                return LinkAliasView(
                  linkAlias: widget.links[index],
                );
              },
              separatorBuilder: (context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}