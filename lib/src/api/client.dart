import 'package:http/http.dart' as http;

/// The main client for interacting with the LangGraph API.
///
/// This class handles authentication and provides the base HTTP client
/// functionality for all API interactions. It serves as the entry point
/// for accessing the various API extensions such as [AssistantApi],
/// [ThreadApi], [ThreadRunsApi], and [CronApi].
class LangGraphClient {
  /// The base URL of the LangGraph API.
  ///
  /// This should be the root URL of your LangGraph server, including the
  /// protocol (http or https) and any base path.
  final String baseUrl;

  /// The API key for authenticating with the LangGraph API.
  ///
  /// If provided, this will be included as a Bearer token in the
  /// Authorization header for all requests.
  final String? apiKey;

  /// The HTTP client used for making requests.
  ///
  /// By default, a new [http.Client] is created, but a custom client
  /// can be provided for testing or specific configurations.
  final http.Client client;

  /// Creates a new LangGraph API client.
  ///
  /// [baseUrl] is required and should point to your LangGraph server.
  /// [apiKey] is optional but recommended for authenticated endpoints.
  /// [client] is optional and allows you to provide a custom HTTP client.
  LangGraphClient({
    required this.baseUrl,
    this.apiKey,
    http.Client? client,
  }) : client = client ?? http.Client();

  /// Returns the headers to be included in all API requests.
  ///
  /// These headers include the Content-Type and, if an API key is
  /// provided, the Authorization header with the Bearer token.
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        if (apiKey != null) 'Authorization': 'Bearer $apiKey',
      };
}

/// Exception thrown when an error occurs during API requests.
///
/// This exception includes a message describing the error and optionally
/// the HTTP status code that was returned by the API.
class LangGraphApiException implements Exception {
  /// A description of the error that occurred.
  final String message;

  /// The HTTP status code returned by the API, if available.
  final int? statusCode;

  /// Creates a new API exception with the given message and optional status code.
  LangGraphApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'LangGraphApiException: $message (Status: $statusCode)';
}
