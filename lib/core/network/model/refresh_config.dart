class RefreshConfig {
  final String refreshUrl;
  final Map<String, dynamic>? refreshHeaders;
  final Map<String, dynamic>? refreshExtraBody;

  const RefreshConfig({
    required this.refreshUrl,
    this.refreshHeaders,
    this.refreshExtraBody,
  });
}
