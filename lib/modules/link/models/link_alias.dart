import 'package:equatable/equatable.dart';

class LinkAlias extends Equatable {
  final String alias;
  final String originalUrl;
  final String shortUrl;

  const LinkAlias({
    required this.alias,
    required this.originalUrl,
    required this.shortUrl,
  });

  Map<String, dynamic> toJson() => {
        'alias': alias,
        'originalUrl': originalUrl,
        'shortUrl': shortUrl,
      };

  @override
  List<Object?> get props => [alias, originalUrl, shortUrl];
}
