import 'dart:convert';

import 'client.dart';
import '../models/checkpoint_config.dart';
import '../models/thread.dart';

extension ThreadApi on LangGraphClient {
  Future<Thread> createThread({
    String? threadId,
    Map<String, dynamic>? metadata,
    String ifExists = 'raise',
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/threads'),
        headers: headers,
        body: jsonEncode({
          if (threadId != null) 'thread_id': threadId,
          if (metadata != null) 'metadata': metadata,
          'if_exists': ifExists,
        }),
      );

      if (response.statusCode == 200) {
        return Thread.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to create thread',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to create thread: $e');
    }
  }

  Future<List<Thread>> searchThreads({
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? values,
    String? status,
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/threads/search'),
        headers: headers,
        body: jsonEncode({
          if (metadata != null) 'metadata': metadata,
          if (values != null) 'values': values,
          if (status != null) 'status': status,
          'limit': limit,
          'offset': offset,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Thread.fromJson(json)).toList();
      }
      throw LangGraphApiException(
        'Failed to search threads',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to search threads: $e');
    }
  }

  Future<ThreadState> getThreadState(String threadId) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/threads/$threadId/state'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return ThreadState.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to get thread state',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to get thread state: $e');
    }
  }

  Future<Map<String, dynamic>> updateThreadState(
      String threadId, {
        dynamic values,
        CheckpointConfig? checkpoint,
        String? asNode,
      }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/threads/$threadId/state'),
        headers: headers,
        body: jsonEncode({
          if (values != null) 'values': values,
          if (checkpoint != null) 'checkpoint': checkpoint.toJson(),
          if (asNode != null) 'as_node': asNode,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw LangGraphApiException(
        'Failed to update thread state',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to update thread state: $e');
    }
  }

  Future<List<ThreadState>> getThreadHistory(
      String threadId, {
        int limit = 10,
        String? before,
      }) async {
    try {
      final queryParams = {
        'limit': limit.toString(),
        if (before != null) 'before': before,
      };

      final response = await client.get(
        Uri.parse('$baseUrl/threads/$threadId/history')
            .replace(queryParameters: queryParams),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ThreadState.fromJson(json)).toList();
      }
      throw LangGraphApiException(
        'Failed to get thread history',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to get thread history: $e');
    }
  }

  Future<Thread> copyThread(String threadId) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/threads/$threadId/copy'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return Thread.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to copy thread',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to copy thread: $e');
    }
  }
}
