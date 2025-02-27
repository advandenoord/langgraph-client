import 'package:http/http.dart' as http;


class LangGraphClient {
  final String baseUrl;
  final String? apiKey;
  final http.Client client;

  LangGraphClient({
    required this.baseUrl,
    this.apiKey,
    http.Client? client,
  }) : client = client ?? http.Client();

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    if (apiKey != null) 'Authorization': 'Bearer $apiKey',
  };
}


class LangGraphApiException implements Exception {
  final String message;
  final int? statusCode;

  LangGraphApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'LangGraphApiException: $message (Status: $statusCode)';
}