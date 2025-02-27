import 'package:json_annotation/json_annotation.dart';
import 'command.dart';
import 'config.dart';

part 'run.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Run {
  @JsonKey(name: 'run_id')
  final String runId;

  @JsonKey(name: 'thread_id')
  final String threadId;

  @JsonKey(name: 'assistant_id')
  final String assistantId;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final String status;
  final Map<String, dynamic> metadata;
  final Map<String, dynamic> kwargs;

  @JsonKey(name: 'multitask_strategy')
  final String multitaskStrategy;

  Run({
    required this.runId,
    required this.threadId,
    required this.assistantId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.metadata,
    required this.kwargs,
    required this.multitaskStrategy,
  });

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);

  Map<String, dynamic> toJson() => _$RunToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RunCreateStateful {
  @JsonKey(name: 'assistant_id')
  final String assistantId;

  final Map<String, dynamic>? input;
  final Command? command;
  final Map<String, dynamic>? metadata;
  final Config? config;
  final String? webhook;

  @JsonKey(name: 'interrupt_before')
  final dynamic interruptBefore;

  @JsonKey(name: 'interrupt_after')
  final dynamic interruptAfter;

  @JsonKey(name: 'stream_mode')
  final dynamic streamMode;

  @JsonKey(name: 'stream_subgraphs')
  final bool streamSubgraphs;

  @JsonKey(name: 'on_disconnect')
  final String onDisconnect;

  @JsonKey(name: 'feedback_keys')
  final List<String>? feedbackKeys;

  @JsonKey(name: 'multitask_strategy')
  final String multitaskStrategy;

  @JsonKey(name: 'if_not_exists')
  final String ifNotExists;

  @JsonKey(name: 'after_seconds')
  final int? afterSeconds;

  RunCreateStateful({
    required this.assistantId,
    this.input,
    this.command,
    this.metadata,
    this.config,
    this.webhook,
    this.interruptBefore,
    this.interruptAfter,
    this.streamMode = 'messages',
    this.streamSubgraphs = false,
    this.onDisconnect = 'cancel',
    this.feedbackKeys,
    this.multitaskStrategy = 'reject',
    this.ifNotExists = 'reject',
    this.afterSeconds,
  });

  factory RunCreateStateful.fromJson(Map<String, dynamic> json) => _$RunCreateStatefulFromJson(json);

  Map<String, dynamic> toJson() => _$RunCreateStatefulToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RunCreateStateless {
  @JsonKey(name: 'assistant_id')
  final String assistantId;

  final Map<String, dynamic>? input;
  final Command? command;
  final Map<String, dynamic>? metadata;
  final Config? config;
  final String? webhook;

  @JsonKey(name: 'interrupt_before')
  final dynamic interruptBefore;

  @JsonKey(name: 'interrupt_after')
  final dynamic interruptAfter;

  @JsonKey(name: 'stream_mode')
  final dynamic streamMode;

  @JsonKey(name: 'feedback_keys')
  final List<String>? feedbackKeys;

  @JsonKey(name: 'stream_subgraphs')
  final bool streamSubgraphs;

  @JsonKey(name: 'on_completion')
  final String onCompletion;

  @JsonKey(name: 'on_disconnect')
  final String onDisconnect;

  @JsonKey(name: 'after_seconds')
  final int? afterSeconds;

  RunCreateStateless({
    required this.assistantId,
    this.input,
    this.command,
    this.metadata,
    this.config,
    this.webhook,
    this.interruptBefore,
    this.interruptAfter,
    this.streamMode = 'values',
    this.feedbackKeys,
    this.streamSubgraphs = false,
    this.onCompletion = 'delete',
    this.onDisconnect = 'cancel',
    this.afterSeconds,
  });

  factory RunCreateStateless.fromJson(Map<String, dynamic> json) => _$RunCreateStatelessFromJson(json);

  Map<String, dynamic> toJson() => _$RunCreateStatelessToJson(this);
}
