import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:langgraph_client/langgraph_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'store_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late LangGraphClient client;

  final baseUrl = 'http://example.com';
  final apiKey = 'test-api-key';

  setUp(() {
    mockClient = MockClient();
    client = LangGraphClient(
      baseUrl: baseUrl,
      apiKey: apiKey,
      client: mockClient,
    );
  });

  group('Store API', () {
    test('createStoreItem creates a store item', () async {
      // Arrange
      final request = StoreItemCreate(
        namespace: ['test', 'namespace'],
        id: 'test-id',
        data: {'key': 'value'},
        metadata: {'tag': 'test'},
      );

      final responseData = {
        'namespace': ['test', 'namespace'],
        'id': 'test-id',
        'data': {'key': 'value'},
        'metadata': {'tag': 'test'},
        'created_at': '2023-01-01T00:00:00.000Z',
        'updated_at': '2023-01-01T00:00:00.000Z',
      };

      when(mockClient.post(
        Uri.parse('$baseUrl/store/items'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await client.createStoreItem(request);

      // Assert
      expect(result.namespace, ['test', 'namespace']);
      expect(result.id, 'test-id');
      expect(result.data, {'key': 'value'});
      expect(result.metadata, {'tag': 'test'});
      verify(mockClient.post(
        Uri.parse('$baseUrl/store/items'),
        headers: client.headers,
        body: anyNamed('body'),
      )).called(1);
    });

    test('getStoreItem fetches a store item', () async {
      // Arrange
      final namespace = ['test', 'namespace'];
      final id = 'test-id';
      final responseData = {
        'namespace': namespace,
        'id': id,
        'data': {'key': 'value'},
        'metadata': {'tag': 'test'},
        'created_at': '2023-01-01T00:00:00.000Z',
        'updated_at': '2023-01-01T00:00:00.000Z',
      };

      when(mockClient.get(
        Uri.parse('$baseUrl/store/items')
            .replace(queryParameters: {'namespace': namespace, 'id': id}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await client.getStoreItem(namespace, id);

      // Assert
      expect(result.namespace, namespace);
      expect(result.id, id);
      expect(result.data, {'key': 'value'});
      verify(mockClient.get(
        Uri.parse('$baseUrl/store/items')
            .replace(queryParameters: {'namespace': namespace, 'id': id}),
        headers: client.headers,
      )).called(1);
    });

    test('searchStoreItems searches for store items', () async {
      // Arrange
      final request = StoreItemSearch(
        namespace: ['test', 'namespace'],
        filter: {'tag': 'test'},
      );

      final responseData = [
        {
          'namespace': ['test', 'namespace'],
          'id': 'item-1',
          'data': {'key': 'value1'},
          'metadata': {'tag': 'test'},
          'created_at': '2023-01-01T00:00:00.000Z',
          'updated_at': '2023-01-01T00:00:00.000Z',
        },
        {
          'namespace': ['test', 'namespace'],
          'id': 'item-2',
          'data': {'key': 'value2'},
          'metadata': {'tag': 'test'},
          'created_at': '2023-01-01T00:00:00.000Z',
          'updated_at': '2023-01-01T00:00:00.000Z',
        },
      ];

      when(mockClient.post(
        Uri.parse('$baseUrl/store/items/search'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final results = await client.searchStoreItems(request);

      // Assert
      expect(results.length, 2);
      expect(results[0].id, 'item-1');
      expect(results[1].id, 'item-2');
      verify(mockClient.post(
        Uri.parse('$baseUrl/store/items/search'),
        headers: client.headers,
        body: anyNamed('body'),
      )).called(1);
    });

    test('deleteStoreItem deletes a store item', () async {
      // Arrange
      final namespace = ['test', 'namespace'];
      final id = 'test-id';

      when(mockClient.delete(
        Uri.parse('$baseUrl/store/items')
            .replace(queryParameters: {'namespace': namespace, 'id': id}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('', 200));

      // Act & Assert
      await expectLater(client.deleteStoreItem(namespace, id), completes);
      verify(mockClient.delete(
        Uri.parse('$baseUrl/store/items')
            .replace(queryParameters: {'namespace': namespace, 'id': id}),
        headers: client.headers,
      )).called(1);
    });

    test('listStoreNamespaces lists namespaces', () async {
      // Arrange
      final responseData = {
        'namespaces': ['namespace1', 'namespace2']
      };

      when(mockClient.get(
        Uri.parse('$baseUrl/store/namespaces'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final namespaces = await client.listStoreNamespaces();

      // Assert
      expect(namespaces, ['namespace1', 'namespace2']);
      verify(mockClient.get(
        Uri.parse('$baseUrl/store/namespaces'),
        headers: client.headers,
      )).called(1);
    });
  });
}
