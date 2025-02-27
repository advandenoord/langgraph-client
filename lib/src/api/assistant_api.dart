import 'dart:convert';

import 'client.dart';
import '../models/assistant.dart';

// POST /assistants
extension AssistantApi on LangGraphClient {
  Future<Assistant> createAssistant({
    required String graphId,
    String? assistantId,
    AssistantConfig? config,
    Map<String, dynamic>? metadata,
    String ifExists = 'raise',
    String? name,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/assistants'),
        headers: headers,
        body: jsonEncode({
          if (assistantId != null) 'assistant_id': assistantId,
          'graph_id': graphId,
          if (config != null) 'config': config.toJson(),
          if (metadata != null) 'metadata': metadata,
          'if_exists': ifExists,
          if (name != null) 'name': name,
        }),
      );

      if (response.statusCode == 200) {
        return Assistant.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to create assistant',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to create assistant: $e');
    }
  }

  // POST /assistants/search
  Future<List<Assistant>> searchAssistants({
    Map<String, dynamic>? metadata,
    String? graphId,
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/assistants/search'),
        headers: headers,
        body: jsonEncode({
          if (metadata != null) 'metadata': metadata,
          if (graphId != null) 'graph_id': graphId,
          'limit': limit,
          'offset': offset,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Assistant.fromJson(json)).toList();
      }
      throw LangGraphApiException(
        'Failed to search assistants',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to search assistants: $e');
    }
  }

  // GET /assistants/{assistant_id}
  Future<Assistant> getAssistant(String assistantId) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/assistants/$assistantId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return Assistant.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to get assistant',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to get assistant: $e');
    }
  }

  // DELETE /assistants/{assistant_id}
  Future<void> deleteAssistant(String assistantId) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/assistants/$assistantId'),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw LangGraphApiException(
          'Failed to delete assistant',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to delete assistant: $e');
    }
  }


  // PATCH /assistants/{assistant_id}
  Future<Assistant> updateAssistant(
      String assistantId, {
        String? graphId,
        AssistantConfig? config,
        Map<String, dynamic>? metadata,
        String? name,
      }) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/assistants/$assistantId'),
        headers: headers,
        body: jsonEncode({
          if (graphId != null) 'graph_id': graphId,
          if (config != null) 'config': config.toJson(),
          if (metadata != null) 'metadata': metadata,
          if (name != null) 'name': name,
        }),
      );

      if (response.statusCode == 200) {
        return Assistant.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to update assistant',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to update assistant: $e');
    }
  }
}
