class HttpConfig {
  final String host;
  final int port;

  const HttpConfig({
    this.host = '172.30.48.1',
    this.port = 8080,
  });

  get url => '$host:$port';
}
