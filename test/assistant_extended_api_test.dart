import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:langgraph_client/langgraph_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'assistant_extended_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late LangGraphClient client;

  final baseUrl = 'http://example.com';
  final apiKey = 'test-api-key';
  final assistantId = 'test-assistant';

  setUp(() {
    mockClient = MockClient();
    client = LangGraphClient(
      baseUrl: baseUrl,
      apiKey: apiKey,
      client: mockClient,
    );
  });

  group('AssistantApi extended endpoints', () {
    test('listAssistantVersions lists all assistant versions', () async {
      // Arrange
      final versions = [
        {
          'assistant_id': assistantId,
          'version': 1,
          'graph_id': 'graph1',
          'config': {
            'tags': ['v1'],
            'recursion_limit': 10
          },
          'created_at': '2023-01-01T00:00:00.000Z',
          'metadata': {},
          'name': 'Version 1',
        },
        {
          'assistant_id': assistantId,
          'version': 2,
          'graph_id': 'graph1',
          'config': {
            'tags': ['v2'],
            'recursion_limit': 10
          },
          'created_at': '2023-01-02T00:00:00.000Z',
          'metadata': {},
          'name': 'Version 2',
        }
      ];

      when(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/versions'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(versions), 200));

      // Act
      final result = await client.listAssistantVersions(assistantId);

      // Assert
      expect(result.length, 2);
      expect(result[0].version, 1);
      expect(result[1].version, 2);
      verify(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/versions'),
        headers: client.headers,
      )).called(1);
    });

    test('getLatestAssistantVersion gets the latest version', () async {
      // Arrange
      final version = {
        'assistant_id': assistantId,
        'version': 3,
        'graph_id': 'graph1',
        'config': {
          'tags': ['latest'],
          'recursion_limit': 10
        },
        'created_at': '2023-01-03T00:00:00.000Z',
        'metadata': {},
        'name': 'Latest Version',
      };

      when(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/latest'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(version), 200));

      // Act
      final result = await client.getLatestAssistantVersion(assistantId);

      // Assert
      expect(result.assistantId, assistantId);
      expect(result.version, 3);
      expect(result.name, 'Latest Version');
      verify(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/latest'),
        headers: client.headers,
      )).called(1);
    });

    test('getAssistantGraph gets the graph definition', () async {
      // Arrange
      final graph = {
        'nodes': {
          'node1': {'type': 'call', 'action': 'action1'},
          'node2': {'type': 'call', 'action': 'action2'},
        },
        'edges': {
          'node1': ['node2'],
          'node2': [],
        }
      };

      when(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/graph'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(graph), 200));

      // Act
      final result = await client.getAssistantGraph(assistantId);

      // Assert
      expect(result['nodes']['node1']['type'], 'call');
      expect(result['edges']['node1'][0], 'node2');
      verify(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/graph'),
        headers: client.headers,
      )).called(1);
    });

    test('getAssistantSchemas gets the schema information', () async {
      // Arrange
      final schemas = {
        'input': {
          'type': 'object',
          'properties': {
            'messages': {
              'type': 'array',
              'items': {
                'type': 'object',
                'properties': {
                  'content': {'type': 'string'},
                  'role': {'type': 'string'},
                }
              }
            }
          }
        },
        'output': {
          'type': 'object',
          'properties': {
            'response': {'type': 'string'}
          }
        }
      };

      when(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/schemas'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(schemas), 200));

      // Act
      final result = await client.getAssistantSchemas(assistantId);

      // Assert
      expect(result.input!['type'], 'object');
      expect(result.output!['properties']['response']['type'], 'string');
      verify(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/schemas'),
        headers: client.headers,
      )).called(1);
    });

    test('listAssistantSubgraphs lists subgraph namespaces', () async {
      // Arrange
      final namespaces = {
        'namespaces': ['default', 'tools', 'memory']
      };

      when(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/subgraphs'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(namespaces), 200));

      // Act
      final result = await client.listAssistantSubgraphs(assistantId);

      // Assert
      expect(result, ['default', 'tools', 'memory']);
      verify(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/subgraphs'),
        headers: client.headers,
      )).called(1);
    });

    test('getAssistantSubgraph gets a specific subgraph', () async {
      // Arrange
      final namespace = 'tools';
      final subgraph = {
        'nodes': {
          'tool1': {'type': 'tool', 'name': 'tool1'},
          'tool2': {'type': 'tool', 'name': 'tool2'},
        },
        'edges': {
          'tool1': ['tool2'],
          'tool2': [],
        }
      };

      when(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/subgraphs/$namespace'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(subgraph), 200));

      // Act
      final result = await client.getAssistantSubgraph(assistantId, namespace);

      // Assert
      expect(result.namespace, namespace);
      expect(result.graph['nodes']['tool1']['type'], 'tool');
      verify(mockClient.get(
        Uri.parse('$baseUrl/assistants/$assistantId/subgraphs/$namespace'),
        headers: client.headers,
      )).called(1);
    });
  });
}
