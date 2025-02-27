import 'package:json_annotation/json_annotation.dart';
import 'checkpoint_config.dart';

part 'thread.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Thread {
  @JsonKey(name: 'thread_id')
  final String threadId;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final Map<String, dynamic> metadata;
  final String status;
  final Map<String, dynamic>? values;

  Thread({
    required this.threadId,
    required this.createdAt,
    required this.updatedAt,
    required this.metadata,
    required this.status,
    this.values,
  });

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ThreadState {
  final dynamic values;
  final List<String> next;
  final List<TaskState> tasks;
  final CheckpointConfig checkpoint;
  final Map<String, dynamic> metadata;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'parent_checkpoint')
  final Map<String, dynamic>? parentCheckpoint;

  ThreadState({
    required this.values,
    required this.next,
    required this.tasks,
    required this.checkpoint,
    required this.metadata,
    required this.createdAt,
    this.parentCheckpoint,
  });

  factory ThreadState.fromJson(Map<String, dynamic> json) => _$ThreadStateFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadStateToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TaskState {
  final String id;
  final String name;
  final String? error;
  final List<dynamic>? interrupts;
  final CheckpointConfig? checkpoint;
  final ThreadState? state;

  TaskState({
    required this.id,
    required this.name,
    this.error,
    this.interrupts,
    this.checkpoint,
    this.state,
  });

  factory TaskState.fromJson(Map<String, dynamic> json) => _$TaskStateFromJson(json);

  Map<String, dynamic> toJson() => _$TaskStateToJson(this);
}
