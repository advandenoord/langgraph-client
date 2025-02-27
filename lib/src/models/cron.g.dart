// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cron.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cron _$CronFromJson(Map<String, dynamic> json) => Cron(
      cronId: json['cron_id'] as String,
      threadId: json['thread_id'] as String,
      endTime: DateTime.parse(json['end_time'] as String),
      schedule: json['schedule'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CronToJson(Cron instance) => <String, dynamic>{
      'cron_id': instance.cronId,
      'thread_id': instance.threadId,
      'end_time': instance.endTime.toIso8601String(),
      'schedule': instance.schedule,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'payload': instance.payload,
    };

CronCreate _$CronCreateFromJson(Map<String, dynamic> json) => CronCreate(
      schedule: json['schedule'] as String,
      assistantId: json['assistant_id'] as String,
      input: json['input'] as Map<String, dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      config: json['config'] == null
          ? null
          : Config.fromJson(json['config'] as Map<String, dynamic>),
      webhook: json['webhook'] as String?,
      interruptBefore: json['interrupt_before'],
      interruptAfter: json['interrupt_after'],
      multitaskStrategy: json['multitask_strategy'] as String? ?? 'reject',
    );

Map<String, dynamic> _$CronCreateToJson(CronCreate instance) =>
    <String, dynamic>{
      'schedule': instance.schedule,
      'assistant_id': instance.assistantId,
      if (instance.input case final value?) 'input': value,
      if (instance.metadata case final value?) 'metadata': value,
      if (instance.config?.toJson() case final value?) 'config': value,
      if (instance.webhook case final value?) 'webhook': value,
      if (instance.interruptBefore case final value?) 'interrupt_before': value,
      if (instance.interruptAfter case final value?) 'interrupt_after': value,
      'multitask_strategy': instance.multitaskStrategy,
    };

CronSearch _$CronSearchFromJson(Map<String, dynamic> json) => CronSearch(
      assistantId: json['assistant_id'] as String?,
      threadId: json['thread_id'] as String?,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CronSearchToJson(CronSearch instance) =>
    <String, dynamic>{
      if (instance.assistantId case final value?) 'assistant_id': value,
      if (instance.threadId case final value?) 'thread_id': value,
      'limit': instance.limit,
      'offset': instance.offset,
    };
