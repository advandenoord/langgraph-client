// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkpoint_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckpointConfig _$CheckpointConfigFromJson(Map<String, dynamic> json) =>
    CheckpointConfig(
      threadId: json['thread_id'] as String?,
      checkpointNs: json['checkpoint_ns'] as String?,
      checkpointId: json['checkpoint_id'] as String?,
      checkpointMap: json['checkpoint_map'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CheckpointConfigToJson(CheckpointConfig instance) =>
    <String, dynamic>{
      if (instance.threadId case final value?) 'thread_id': value,
      if (instance.checkpointNs case final value?) 'checkpoint_ns': value,
      if (instance.checkpointId case final value?) 'checkpoint_id': value,
      if (instance.checkpointMap case final value?) 'checkpoint_map': value,
    };
