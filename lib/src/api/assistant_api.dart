import 'dart:convert';

import 'client.dart';
import '../models/assistant.dart';
import '../models/assistant_version.dart';

/// Extension providing assistant management functionality for [LangGraphClient].
///
/// This extension enables creation, retrieval, updating, deletion, and searching
/// of LangGraph assistants, which represent configurable instances of graphs
/// that can be used to process messages in threads. It also provides access to
/// assistant versioning, schemas, and subgraph operations.
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
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns the created [Assistant] object.
  /// Throws [LangGraphApiException] if the request fails.
  Future<Assistant> createAssistant({
    required String graphId,
    String? token,
    String? assistantId,
    AssistantConfig? config,
    Map<String, dynamic>? metadata,
    String ifExists = 'raise',
    String? name,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/assistants'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
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
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns a list of [Assistant] objects matching the search criteria.
  /// Throws [LangGraphApiException] if the request fails.
  Future<List<Assistant>> searchAssistants({
    Map<String, dynamic>? metadata,
    String? token,
    String? graphId,
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/assistants/search'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
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
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns the requested [Assistant] object.
  /// Throws [LangGraphApiException] if the assistant is not found or the request fails.
  Future<Assistant> getAssistant(String assistantId, {String? token}) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/assistants/$assistantId'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
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
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns void on successful deletion.
  /// Throws [LangGraphApiException] if the assistant is not found or the request fails.
  Future<void> deleteAssistant(String assistantId, {String? token}) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/assistants/$assistantId'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
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
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns the updated [Assistant] object.
  /// Throws [LangGraphApiException] if the assistant is not found or the request fails.
  Future<Assistant> updateAssistant(
    String assistantId, {
    String? token,
    String? graphId,
    AssistantConfig? config,
    Map<String, dynamic>? metadata,
    String? name,
  }) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/assistants/$assistantId'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
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

  /// Lists all versions of an assistant.
  ///
  /// [assistantId] is the unique identifier of the assistant.
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns a list of assistant versions.
  /// Throws [LangGraphApiException] if the request fails.
  Future<List<AssistantVersion>> listAssistantVersions(String assistantId,
      {String? token}) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/assistants/$assistantId/versions'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          return data.map((json) => AssistantVersion.fromJson(json)).toList();
        } else if (data is Map && data.containsKey('versions')) {
          return (data['versions'] as List)
              .map((json) => AssistantVersion.fromJson(json))
              .toList();
        }
        return [];
      }
      throw LangGraphApiException(
        'Failed to list assistant versions',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to list assistant versions: $e');
    }
  }

  /// Gets the latest version of an assistant.
  ///
  /// [assistantId] is the unique identifier of the assistant.
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns the latest assistant version.
  /// Throws [LangGraphApiException] if the request fails.
  Future<AssistantVersion> getLatestAssistantVersion(String assistantId,
      {String? token}) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/assistants/$assistantId/latest'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
      );

      if (response.statusCode == 200) {
        return AssistantVersion.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to get latest assistant version',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to get latest assistant version: $e');
    }
  }

  /// Gets the graph definition for an assistant.
  ///
  /// [assistantId] is the unique identifier of the assistant.
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns the graph definition as a JSON map.
  /// Throws [LangGraphApiException] if the request fails.
  Future<Map<String, dynamic>> getAssistantGraph(String assistantId,
      {String? token}) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/assistants/$assistantId/graph'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw LangGraphApiException(
        'Failed to get assistant graph',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to get assistant graph: $e');
    }
  }

  /// Gets the schema information for an assistant.
  ///
  /// [assistantId] is the unique identifier of the assistant.
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns the assistant's input and output schemas.
  /// Throws [LangGraphApiException] if the request fails.
  Future<AssistantSchema> getAssistantSchemas(String assistantId,
      {String? token}) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/assistants/$assistantId/schemas'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
      );

      if (response.statusCode == 200) {
        return AssistantSchema.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to get assistant schemas',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to get assistant schemas: $e');
    }
  }

  /// Lists subgraphs for an assistant.
  ///
  /// [assistantId] is the unique identifier of the assistant.
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns a list of subgraph namespaces.
  /// Throws [LangGraphApiException] if the request fails.
  Future<List<String>> listAssistantSubgraphs(String assistantId,
      {String? token}) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/assistants/$assistantId/subgraphs'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          return data.cast<String>();
        } else if (data is Map && data.containsKey('namespaces')) {
          return (data['namespaces'] as List).cast<String>();
        }
        return [];
      }
      throw LangGraphApiException(
        'Failed to list assistant subgraphs',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to list assistant subgraphs: $e');
    }
  }

  /// Gets a specific subgraph for an assistant.
  ///
  /// [assistantId] is the unique identifier of the assistant.
  /// [namespace] is the namespace of the subgraph to retrieve.
  /// [token] is a security token that can be used by LangGraph Auth.
  ///
  /// Returns the subgraph definition.
  /// Throws [LangGraphApiException] if the request fails.
  Future<AssistantSubgraph> getAssistantSubgraph(
      String assistantId, String namespace,
      {String? token}) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/assistants/$assistantId/subgraphs/$namespace'),
        headers: token == null ? headers : getHeadersWithToken(token: token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AssistantSubgraph(
          namespace: namespace,
          graph: data,
        );
      }
      throw LangGraphApiException(
        'Failed to get assistant subgraph',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to get assistant subgraph: $e');
    }
  }
}
