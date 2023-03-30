import 'package:dio/dio.dart';
import 'package:link_shortener/config/http.dart';
import 'package:link_shortener/modules/link/models/link_alias.dart';

class YourlsLinkRepository implements ILinkRepository {
  late final Dio _dio;

  YourlsLinkRepository({
    HttpConfig httpConfig = const HttpConfig(),
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://${httpConfig.url}/yourls-api.php'
            '?username=example_username'
            '&password=example_password'
            '&format=json',
      ),
    );
  }

  @override
  Future<LinkAlias> shortenUrl(String url) async {
    final response = await _dio.get(
      '&action=shorturl'
      '&url=$url',
    );

    return YoursConverter.fromShortenUrlJson(response);
  }

  @override
  Future<List<LinkAlias>> fetchLinks({int? limit}) async {
    final response = await _dio.get(
      '&action=stats'
      '&filter=last'
      '&limit=$limit',
    );

    return YoursConverter.fromFetchLinksJson(response);
  }
}

abstract class ILinkRepository {
  Future<LinkAlias> shortenUrl(String url);

  Future<List<LinkAlias>> fetchLinks({int? limit});
}

class YoursConverter {
  static LinkAlias fromShortenUrlJson(Response response) {
    return LinkAlias(
      alias: response.data['url']['title'],
      originalUrl: response.data['url']['url'],
      shortUrl: response.data['shorturl'],
    );
  }

  static List<LinkAlias> fromFetchLinksJson(Response response) {
    final linksJson = (response.data['links'] as Map<String, dynamic>);
    return linksJson.values.map((value) {
      return LinkAlias(
        alias: value['title'],
        originalUrl: value['url'],
        shortUrl: value['shorturl'],
      );
    }).toList();
  }
}
