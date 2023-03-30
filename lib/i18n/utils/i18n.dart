import 'package:localization/localization.dart';

abstract class I18N {
  static String titleRecentlyUrls() {
    return 'title_recently_urls'.i18n();
  }

  static String noShortenedLink() {
    return 'no_shortened_link'.i18n();
  }

  static String searchAgain() {
    return 'search_again'.i18n();
  }

  static String typeLinkShorten() {
    return 'type_link_shorten'.i18n();
  }

  static String errorGeneratingUrl() {
    return 'error_generating_url'.i18n();
  }

  static String linkAliasShortUrl(String value) {
    return 'link_alias_short_url'.i18n([value]);
  }

  static String linkAliasOriginalUrl(String value) {
    return 'link_alias_original_url'.i18n([value]);
  }
}
