class ApiConfig {
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;

  const ApiConfig({
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.sendTimeout,
  });

  factory ApiConfig.defaultConfig() {
    return const ApiConfig(
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
    );
  }
}
