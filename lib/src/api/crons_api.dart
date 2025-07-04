import 'dart:convert';

import 'client.dart';
import '../models/cron.dart';

extension CronApi on LangGraphClient {
  Future<Cron> createCron(CronCreate request, {String? token}) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/runs/crons'),
         headers: token == null ? headers : getHeadersWithToken(token: token),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return Cron.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to create cron',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to create cron: $e');
    }
  }

  Future<Cron> createThreadCron(
    String threadId,
    CronCreate request,
    {String? token}
  ) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/threads/$threadId/runs/crons'),
         headers: token == null ? headers : getHeadersWithToken(token: token),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return Cron.fromJson(jsonDecode(response.body));
      }
      throw LangGraphApiException(
        'Failed to create thread cron',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to create thread cron: $e');
    }
  }

  Future<List<Cron>> searchCrons(CronSearch request, {String? token}) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/runs/crons/search'),
         headers: token == null ? headers : getHeadersWithToken(token: token),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Cron.fromJson(json)).toList();
      }
      throw LangGraphApiException(
        'Failed to search crons',
        response.statusCode,
      );
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to search crons: $e');
    }
  }

  Future<void> deleteCron(String cronId, {String? token}) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/runs/crons/$cronId'),
         headers: token == null ? headers : getHeadersWithToken(token: token),
      );

      if (response.statusCode != 200) {
        throw LangGraphApiException(
          'Failed to delete cron',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is LangGraphApiException) rethrow;
      throw LangGraphApiException('Failed to delete cron: $e');
    }
  }
}
