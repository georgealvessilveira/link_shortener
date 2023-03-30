import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/modules/home/controllers/home.dart';
import 'package:link_shortener/modules/link/models/link_alias.dart';
import 'package:link_shortener/modules/link/repositories/link.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_controller_test.mocks.dart';

List<LinkAlias> getLinks(int limit) {
  final links = <LinkAlias>[];
  for (int i = 0; i < limit; i++) {
    links.add(
      LinkAlias(
        alias: 'alias$i',
        originalUrl: 'originalUrl$i',
        shortUrl: 'shortUrl$i',
      ),
    );
  }
  return links;
}

@GenerateMocks([ILinkRepository])
void main() {
  group('Fetch recently links', () {
    final linkRepository = MockILinkRepository();
    final homeController = HomeController(linkRepository: linkRepository);

    const limit = 10;
    final links = getLinks(limit);

    when(linkRepository.fetchLinks(limit: limit))
        .thenAnswer((_) => Future.value(links));

    blocTest(
      'emits state loading and loaded with list of links when fetch recently links',
      build: () => homeController,
      act: (HomeController controller) => controller.fetchRecentlyLinks(),
      expect: () => [
        const HomeState(status: HomeStatus.loading),
        HomeState(status: HomeStatus.loaded, links: links),
      ],
    );
  });

  group('Shorten url', () {
    final linkRepository = MockILinkRepository();
    final homeController = HomeController(linkRepository: linkRepository);

    const url = 'https://stackoverflow.com';
    const linkAlias = LinkAlias(
      alias: 'st.com',
      originalUrl: url,
      shortUrl: 'https://st.com',
    );

    when(linkRepository.shortenUrl(url))
        .thenAnswer((_) => Future.value(linkAlias));

    blocTest(
      'emits states loading and loaded with shortened url',
      build: () => homeController,
      act: (HomeController controller) => controller.shortenUrl(url),
      expect: () => [
        const HomeState(status: HomeStatus.loading),
        const HomeState(status: HomeStatus.loaded, links: [linkAlias]),
      ],
    );
  });
}
