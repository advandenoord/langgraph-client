import 'dart:convert';

import 'client.dart';
import '../models/assistant.dart';

/// Extension providing assistant management functionality for [LangGraphClient].
///
/// This extension enables creation, retrieval, updating, deletion, and searching
/// of LangGraph assistants, which represent configurable instances of graphs
/// that can be used to process messages in threads.
extension AssistantApi on LangGraphClient {
  /// Creates a new assistant with the specified configuration.
  ///
  /// An assistant is a configurable instance of a graph that can be used
  /// to process messages in threads.
  ///
  /// [graphId] is the ID of the graph to use for this assistant.
  /// [assistantId] is an optional custom ID for the assistant. If not provided, one will be generated.
  /// [config] contains optional configuration parameters for the assistant.
  /// [metadata] is optional user-provided metadata for the assistant.
  /// [ifExists] determines behavior when an assistant with the same ID already exists. Options are 'raise', 'update', or 'ignore'.
  /// [name] is an optional name for easier identification of the assistant.
  ///
  /// Returns the created [Assistant] object.
  /// Throws [LangGraphApiException] if the request fails.
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

  /// Searches for assistants matching the specified criteria.
  ///
  /// This method allows filtering assistants by metadata and/or graph ID.
  ///
  /// [metadata] optional metadata filter to match against assistant metadata.
  /// [graphId] optional filter to find assistants associated with a specific graph.
  /// [limit] maximum number of results to return (default: 10).
  /// [offset] number of results to skip for pagination (default: 0).
  ///
  /// Returns a list of [Assistant] objects matching the search criteria.
  /// Throws [LangGraphApiException] if the request fails.
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

  /// Retrieves an assistant by its ID.
  ///
  /// [assistantId] is the unique identifier of the assistant to retrieve.
  ///
  /// Returns the requested [Assistant] object.
  /// Throws [LangGraphApiException] if the assistant is not found or the request fails.
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

  /// Deletes an assistant by its ID.
  ///
  /// [assistantId] is the unique identifier of the assistant to delete.
  ///
  /// Returns void on successful deletion.
  /// Throws [LangGraphApiException] if the assistant is not found or the request fails.
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

  /// Updates an existing assistant with new properties.
  ///
  /// [assistantId] is the unique identifier of the assistant to update.
  /// [graphId] optional new graph ID to associate with this assistant.
  /// [config] optional new configuration parameters for the assistant.
  /// [metadata] optional new metadata for the assistant.
  /// [name] optional new name for the assistant.
  ///
  /// Returns the updated [Assistant] object.
  /// Throws [LangGraphApiException] if the assistant is not found or the request fails.
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
