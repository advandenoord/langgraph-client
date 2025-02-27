import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:langgraph_client/langgraph_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// Generate mocks
@GenerateMocks([http.Client])
import 'crons_api_test.mocks.dart';

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

  group('CronApi extension', () {
    group('createCron', () {
      test('creates cron successfully', () async {
        final mockResponse = {
          'cron_id': 'cron_123',
          'thread_id': 'thread_123',
          'end_time': '2025-02-26T12:00:00Z',
          'schedule': '0 0 * * *',
          'created_at': '2025-02-26T12:00:00Z',
          'updated_at': '2025-02-26T12:00:00Z',
          'payload': {'key': 'value'},
        };

        when(mockClient.post(
          Uri.parse('$baseUrl/runs/crons'),
          headers: client.headers,
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

        final request = CronCreate(
          schedule: '0 0 * * *',
          assistantId: 'assistant_123',
          input: {'key': 'value'},
        );

        final result = await client.createCron(request);

        expect(result, isA<Cron>());
        expect(result.cronId, equals('cron_123'));
        expect(result.payload, equals({'key': 'value'}));

        verify(mockClient.post(
          Uri.parse('$baseUrl/runs/crons'),
          headers: client.headers,
          body: jsonEncode(request.toJson()),
        )).called(1);
      });

      test('throws exception on error', () async {
        when(mockClient.post(
          Uri.parse('$baseUrl/runs/crons'),
          headers: client.headers,
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response('Not found', 404));

        final request = CronCreate(
          schedule: '0 0 * * *',
          assistantId: 'assistant_123',
        );

        expect(
              () => client.createCron(request),
          throwsA(isA<LangGraphApiException>().having((e) => e.statusCode, 'statusCode', 404)),
        );
      });
    });

    group('createThreadCron', () {
      test('creates thread cron successfully', () async {
        final mockResponse = {
          'cron_id': 'cron_123',
          'thread_id': 'thread_123',
          'end_time': '2025-02-26T12:00:00Z',
          'schedule': '0 0 * * *',
          'created_at': '2025-02-26T12:00:00Z',
          'updated_at': '2025-02-26T12:00:00Z',
          'payload': {'key': 'value'},
        };

        when(mockClient.post(
          Uri.parse('$baseUrl/threads/thread_123/runs/crons'),
          headers: client.headers,
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

        final request = CronCreate(
          schedule: '0 0 * * *',
          assistantId: 'assistant_123',
          input: {'key': 'value'},
        );

        final result = await client.createThreadCron('thread_123', request);

        expect(result, isA<Cron>());
        expect(result.cronId, equals('cron_123'));
        expect(result.payload, equals({'key': 'value'}));

        verify(mockClient.post(
          Uri.parse('$baseUrl/threads/thread_123/runs/crons'),
          headers: client.headers,
          body: jsonEncode(request.toJson()),
        )).called(1);
      });

      test('throws exception on error', () async {
        when(mockClient.post(
          Uri.parse('$baseUrl/threads/thread_123/runs/crons'),
          headers: client.headers,
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response('Not found', 404));

        final request = CronCreate(
          schedule: '0 0 * * *',
          assistantId: 'assistant_123',
        );

        expect(
              () => client.createThreadCron('thread_123', request),
          throwsA(isA<LangGraphApiException>().having((e) => e.statusCode, 'statusCode', 404)),
        );
      });
    });

    group('searchCrons', () {
      test('searches crons successfully', () async {
        final mockResponse = [
          {
            'cron_id': 'cron_1',
            'thread_id': 'thread_1',
            'end_time': '2025-02-26T12:00:00Z',
            'schedule': '0 0 * * *',
            'created_at': '2025-02-26T12:00:00Z',
            'updated_at': '2025-02-26T12:00:00Z',
            'payload': {'key': 'value1'},
          },
          {
            'cron_id': 'cron_2',
            'thread_id': 'thread_2',
            'end_time': '2025-02-26T12:00:00Z',
            'schedule': '0 0 * * *',
            'created_at': '2025-02-26T12:00:00Z',
            'updated_at': '2025-02-26T12:00:00Z',
            'payload': {'key': 'value2'},
          },
        ];

        when(mockClient.post(
          Uri.parse('$baseUrl/runs/crons/search'),
          headers: client.headers,
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

        final request = CronSearch(
          assistantId: 'assistant_123',
          limit: 5,
        );

        final results = await client.searchCrons(request);

        expect(results, isA<List<Cron>>());
        expect(results.length, equals(2));
        expect(results[0].cronId, equals('cron_1'));
        expect(results[1].cronId, equals('cron_2'));

        verify(mockClient.post(
          Uri.parse('$baseUrl/runs/crons/search'),
          headers: client.headers,
          body: jsonEncode(request.toJson()),
        )).called(1);
      });
    });

    group('deleteCron', () {
      test('deletes cron successfully', () async {
        when(mockClient.delete(
          Uri.parse('$baseUrl/runs/crons/cron_123'),
          headers: client.headers,
        )).thenAnswer((_) async => http.Response('', 200));

        await client.deleteCron('cron_123');

        verify(mockClient.delete(
          Uri.parse('$baseUrl/runs/crons/cron_123'),
          headers: client.headers,
        )).called(1);
      });

      test('throws exception on error', () async {
        when(mockClient.delete(
          Uri.parse('$baseUrl/runs/crons/cron_123'),
          headers: client.headers,
        )).thenAnswer((_) async => http.Response('Not found', 404));

        expect(
              () => client.deleteCron('cron_123'),
          throwsA(isA<LangGraphApiException>().having((e) => e.statusCode, 'statusCode', 404)),
        );
      });
    });
  });
}