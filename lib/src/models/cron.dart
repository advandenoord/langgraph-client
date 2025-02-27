import 'package:json_annotation/json_annotation.dart';
import 'config.dart';

part 'cron.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Cron {
  @JsonKey(name: 'cron_id')
  final String cronId;

  @JsonKey(name: 'thread_id')
  final String threadId;

  @JsonKey(name: 'end_time')
  final DateTime endTime;

  final String schedule;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final Map<String, dynamic> payload;

  Cron({
    required this.cronId,
    required this.threadId,
    required this.endTime,
    required this.schedule,
    required this.createdAt,
    required this.updatedAt,
    required this.payload,
  });

  factory Cron.fromJson(Map<String, dynamic> json) => _$CronFromJson(json);

  Map<String, dynamic> toJson() => _$CronToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CronCreate {
  final String schedule;

  @JsonKey(name: 'assistant_id')
  final String assistantId;

  final Map<String, dynamic>? input;
  final Map<String, dynamic>? metadata;
  final Config? config;
  final String? webhook;

  @JsonKey(name: 'interrupt_before')
  final dynamic interruptBefore;

  @JsonKey(name: 'interrupt_after')
  final dynamic interruptAfter;

  @JsonKey(name: 'multitask_strategy')
  final String multitaskStrategy;

  CronCreate({
    required this.schedule,
    required this.assistantId,
    this.input,
    this.metadata,
    this.config,
    this.webhook,
    this.interruptBefore,
    this.interruptAfter,
    this.multitaskStrategy = 'reject',
  });

  factory CronCreate.fromJson(Map<String, dynamic> json) => _$CronCreateFromJson(json);

  Map<String, dynamic> toJson() => _$CronCreateToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CronSearch {
  @JsonKey(name: 'assistant_id')
  final String? assistantId;

  @JsonKey(name: 'thread_id')
  final String? threadId;

  final int limit;
  final int offset;

  CronSearch({
    this.assistantId,
    this.threadId,
    this.limit = 10,
    this.offset = 0,
  });

  factory CronSearch.fromJson(Map<String, dynamic> json) => _$CronSearchFromJson(json);

  Map<String, dynamic> toJson() => _$CronSearchToJson(this);
}
