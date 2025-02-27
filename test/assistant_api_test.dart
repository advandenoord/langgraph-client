import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:langgraph_client/langgraph_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// Generate mocks
@GenerateMocks([http.Client])
import 'assistant_api_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late LangGraphClient client;
  const baseUrl = 'https://api.example.com';
  const apiKey = 'test_api_key';

  setUp(() {
    mockClient = MockClient();
    client = LangGraphClient(
      baseUrl: baseUrl,
      apiKey: apiKey,
      client: mockClient,
    );
  });

  group('AssistantApi extension', () {
    group('createAssistant', () {
      test('creates assistant successfully', () async {
        final mockResponse = {
          'assistant_id': 'assistant_123',
          'graph_id': 'graph_123',
          'config': {},
          'created_at': '2025-02-26T12:00:00Z',
          'updated_at': '2025-02-26T12:00:00Z',
          'metadata': {'key': 'value'},
        };

        when(mockClient.post(
          Uri.parse('$baseUrl/assistants'),
          headers: client.headers,
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

        final result = await client.createAssistant(
          graphId: 'graph_123',
          assistantId: 'assistant_123',
          metadata: {'key': 'value'},
        );

        expect(result, isA<Assistant>());
        expect(result.assistantId, equals('assistant_123'));
        expect(result.metadata, equals({'key': 'value'}));

        verify(mockClient.post(
          Uri.parse('$baseUrl/assistants'),
          headers: client.headers,
          body: jsonEncode({
            'assistant_id': 'assistant_123',
            'graph_id': 'graph_123',
            'metadata': {'key': 'value'},
            'if_exists': 'raise',
          }),
        )).called(1);
      });

      test('throws exception on error', () async {
        when(mockClient.post(
          Uri.parse('$baseUrl/assistants'),
          headers: client.headers,
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response('Not found', 404));

        expect(
              () => client.createAssistant(graphId: 'graph_123'),
          throwsA(isA<LangGraphApiException>().having((e) => e.statusCode, 'statusCode', 404)),
        );
      });
    });

    group('searchAssistants', () {
      test('searches assistants successfully', () async {
        final mockResponse = [
          {
            'assistant_id': 'assistant_1',
            'graph_id': 'graph_1',
            'config': {},
            'created_at': '2025-02-26T12:00:00Z',
            'updated_at': '2025-02-26T12:00:00Z',
            'metadata': {'key': 'value1'},
          },
          {
            'assistant_id': 'assistant_2',
            'graph_id': 'graph_2',
            'config': {},
            'created_at': '2025-02-26T12:00:00Z',
            'updated_at': '2025-02-26T12:00:00Z',
            'metadata': {'key': 'value2'},
          },
        ];

        when(mockClient.post(
          Uri.parse('$baseUrl/assistants/search'),
          headers: client.headers,
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

        final results = await client.searchAssistants(metadata: {'key': 'value'}, limit: 5);

        expect(results, isA<List<Assistant>>());
        expect(results.length, equals(2));
        expect(results[0].assistantId, equals('assistant_1'));
        expect(results[1].assistantId, equals('assistant_2'));

        verify(mockClient.post(
          Uri.parse('$baseUrl/assistants/search'),
          headers: client.headers,
          body: jsonEncode({
            'metadata': {'key': 'value'},
            'limit': 5,
            'offset': 0,
          }),
        )).called(1);
      });
    });

    group('getAssistant', () {
      test('gets assistant successfully', () async {
        final mockResponse = {
          'assistant_id': 'assistant_123',
          'graph_id': 'graph_123',
          'config': {},
          'created_at': '2025-02-26T12:00:00Z',
          'updated_at': '2025-02-26T12:00:00Z',
          'metadata': {'key': 'value'},
        };

        when(mockClient.get(
          Uri.parse('$baseUrl/assistants/assistant_123'),
          headers: client.headers,
        )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

        final result = await client.getAssistant('assistant_123');

        expect(result, isA<Assistant>());
        expect(result.assistantId, equals('assistant_123'));
        expect(result.metadata, equals({'key': 'value'}));
      });
    });

    group('deleteAssistant', () {
      test('deletes assistant successfully', () async {
        when(mockClient.delete(
          Uri.parse('$baseUrl/assistants/assistant_123'),
          headers: client.headers,
        )).thenAnswer((_) async => http.Response('', 200));

        await client.deleteAssistant('assistant_123');

        verify(mockClient.delete(
          Uri.parse('$baseUrl/assistants/assistant_123'),
          headers: client.headers,
        )).called(1);
      });
    });

    group('updateAssistant', () {
      test('updates assistant successfully', () async {
        final mockResponse = {
          'assistant_id': 'assistant_123',
          'graph_id': 'graph_123',
          'config': {},
          'created_at': '2025-02-26T12:00:00Z',
          'updated_at': '2025-02-26T12:00:00Z',
          'metadata': {'key': 'value'},
        };

        when(mockClient.patch(
          Uri.parse('$baseUrl/assistants/assistant_123'),
          headers: client.headers,
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

        final result = await client.updateAssistant(
          'assistant_123',
          graphId: 'graph_123',
          metadata: {'key': 'value'},
        );

        expect(result, isA<Assistant>());
        expect(result.assistantId, equals('assistant_123'));
        expect(result.metadata, equals({'key': 'value'}));

        verify(mockClient.patch(
          Uri.parse('$baseUrl/assistants/assistant_123'),
          headers: client.headers,
          body: jsonEncode({
            'graph_id': 'graph_123',
            'metadata': {'key': 'value'},
          }),
        )).called(1);
      });
    });
  });
}