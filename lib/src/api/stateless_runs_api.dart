import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sse_stream/sse_stream.dart';

import 'client.dart';
import '../models/run.dart';

/// Stateless Runs API Extension
extension StatelessRunsApi on LangGraphClient {
  Future<Map<String, dynamic>> createBackgroundRun(RunCreateStateless request,
      {String? token}) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/runs'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw LangGraphApiException(
        'Failed to create background run',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to create background run: $e');
    }
  }

  Stream<SseEvent> streamRun(RunCreateStateless request,
      {String? token}) async* {
    try {
      final streamedRequest = http.Request(
        'POST',
        Uri.parse('$baseUrl/runs/stream'),
      );

      streamedRequest.headers
          .addAll(token == null ? headers : getHeadersWithToken(token: token));
      streamedRequest.body = jsonEncode(request.toJson());

      final response = await client.send(streamedRequest);

      if (response.statusCode != 200) {
        throw LangGraphApiException(
          'Failed to stream run',
          response.statusCode,
        );
      }

      await for (final chunk in response.stream
          .transform(utf8.decoder)
          .transform(const SseEventTransformer())) {
        yield chunk;
      }
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to stream run: $e');
    }
  }

  Future<Map<String, dynamic>> waitForRun(RunCreateStateless request,
      {String? token}) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/runs/wait'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw LangGraphApiException(
        'Failed to wait for run',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to wait for run: $e');
    }
  }

  Future<List<Map<String, dynamic>>> createRunBatch(
      List<RunCreateStateless> requests,
      {String? token}) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/runs/batch'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
        body: jsonEncode(requests.map((r) => r.toJson()).toList()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      throw LangGraphApiException(
        'Failed to create run batch',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to create run batch: $e');
    }
  }

  /// Cancels a stateless run.
  ///
  /// [runId] is the unique identifier of the run to cancel.
  /// [wait] specifies whether to wait for the run to be fully cancelled before returning (default: false).
  /// [action] specifies the action to take: 'interrupt' (default) or 'terminate'.
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns void on successful cancellation.
  /// Throws [LangGraphApiException] if the request fails.
  Future<void> cancelRun(
    String runId, {
    bool wait = false,
    String action = 'interrupt',
    String? token,
  }) async {
    try {
      final queryParams = {
        'wait': wait.toString(),
        'action': action,
      };

      final response = await client.post(
        Uri.parse('$baseUrl/runs/cancel')
            .replace(queryParameters: {...queryParams, 'run_id': runId}),
        headers: token == null ? headers : getHeadersWithToken(token: token),
      );

      if (response.statusCode != 200) {
        throw LangGraphApiException(
          'Failed to cancel run',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to cancel run: $e');
    }
  }
}
