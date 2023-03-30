import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/config/http.dart';
import 'package:link_shortener/modules/link/repositories/link.dart';
import 'package:mock_web_server/mock_web_server.dart';

void main() async {
  final server = MockWebServer();

  setUp(() async => await server.start());
  tearDown(() async => await server.shutdown());

  test('Yourls shorten link', () async {
    const url = 'https://stackoverflow.com';
    const jsonResponse = {
      'url': {
        'url': url,
        'title': 'Stack Overflow',
      },
      'shorturl': 'https://local.com/sto'
    };
    
    final response = Response(
      requestOptions: RequestOptions(),
      data: jsonResponse,
    );
    final expectedLinkAlias = YoursConverter.fromShortenUrlJson(response);

    final mockResponse = MockResponse()
      ..httpCode = 200
      ..body = jsonEncode(jsonResponse)
      ..headers = {'content-type': 'application/json; charset=utf-8'};

    server.enqueueResponse(mockResponse);

    final httpConfig = HttpConfig(host: server.host, port: server.port);
    final linkRepository = YourlsLinkRepository(httpConfig: httpConfig);
    final linkAlias = await linkRepository.shortenUrl(url);

    final request = server.takeRequest();

    expect(request.method, 'GET');
    expect(linkAlias, expectedLinkAlias);
  });

  test('Yourls fetch links', () async {
    const jsonResponse = {
      'links': {
        'link_1': {
          'title': 'Stack Overflow',
          'url': 'https://stackoverflow.com',
          'shorturl': 'https://local.com/sto',
        },
        'link_2': {
          'title': 'YouTube',
          'url': 'https://youtube.com',
          'shorturl': 'https://local.com/yt',
        },
      },
    };

    final response = Response(
      requestOptions: RequestOptions(),
      data: jsonResponse,
    );
    final expectedLink = YoursConverter.fromFetchLinksJson(response);

    final mockResponse = MockResponse()
      ..httpCode = 200
      ..body = jsonEncode(jsonResponse)
      ..headers = {'content-type': 'application/json; charset=utf-8'};

    server.enqueueResponse(mockResponse);

    final httpConfig = HttpConfig(host: server.host, port: server.port);
    final linkRepository = YourlsLinkRepository(httpConfig: httpConfig);
    final links = await linkRepository.fetchLinks(limit: jsonResponse.length);

    final request = server.takeRequest();

    expect(request.method, 'GET');
    expect(links, expectedLink);
  });
}
