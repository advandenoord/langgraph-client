import 'package:json_annotation/json_annotation.dart';
import 'command.dart';
import 'config.dart';

part 'run.g.dart';

/// Represents a LangGraph run, which is an execution of a graph on a thread.
///
/// A run is associated with a specific thread and assistant, and contains
/// information about the execution status and metadata.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Run {
  /// Unique identifier for the run.
  @JsonKey(name: 'run_id')
  final String runId;

  /// Identifier of the thread this run is executing on.
  @JsonKey(name: 'thread_id')
  final String threadId;

  /// Identifier of the assistant that is executing this run.
  @JsonKey(name: 'assistant_id')
  final String assistantId;

  /// Timestamp when the run was created.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Timestamp when the run was last updated.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// Current status of the run (e.g., 'in_progress', 'completed', 'failed').
  final String status;

  /// User-provided metadata associated with this run.
  final Map<String, dynamic> metadata;

  /// Additional arguments passed to the run.
  final Map<String, dynamic> kwargs;

  /// Strategy for handling multiple concurrent runs on the same thread.
  ///
  /// Options include 'reject', 'queue', or 'concurrent'.
  @JsonKey(name: 'multitask_strategy')
  final String multitaskStrategy;

  /// Creates a new run instance.
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

  /// Creates a run from a JSON map.
  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);

  /// Converts this run to a JSON map.
  Map<String, dynamic> toJson() => _$RunToJson(this);
}

/// Parameters for creating a stateful run on a thread.
///
/// This class is used to specify the configuration for a new run
/// on an existing thread, including input data, streaming options,
/// and execution behavior.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RunCreateStateful {
  /// Identifier of the assistant to use for this run.
  @JsonKey(name: 'assistant_id')
  final String assistantId;

  /// Input data to provide to the graph for this run.
  final Map<String, dynamic>? input;

  /// Optional command to execute as part of this run.
  final Command? command;

  /// User-provided metadata to associate with this run.
  final Map<String, dynamic>? metadata;

  /// Additional configuration options for this run.
  final Config? config;

  /// Optional webhook URL to receive notifications about run events.
  final String? webhook;

  /// Node(s) to interrupt execution before.
  ///
  /// Can be a string, a list of strings, or null.
  @JsonKey(name: 'interrupt_before')
  final dynamic interruptBefore;

  /// Node(s) to interrupt execution after.
  ///
  /// Can be a string, a list of strings, or null.
  @JsonKey(name: 'interrupt_after')
  final dynamic interruptAfter;

  /// Determines what values are streamed during execution.
  ///
  /// Options include 'values', 'messages', or 'all'.
  @JsonKey(name: 'stream_mode')
  final dynamic streamMode;

  /// Whether to stream intermediate values from subgraphs.
  @JsonKey(name: 'stream_subgraphs')
  final bool streamSubgraphs;

  /// Action to take when the client disconnects.
  ///
  /// Options include 'cancel', 'keep_going', or 'terminate'.
  @JsonKey(name: 'on_disconnect')
  final String onDisconnect;

  /// Keys to use for feedback in interactive runs.
  @JsonKey(name: 'feedback_keys')
  final List<String>? feedbackKeys;

  /// Strategy for handling multiple concurrent runs on the same thread.
  ///
  /// Options include 'reject', 'queue', or 'concurrent'.
  @JsonKey(name: 'multitask_strategy')
  final String multitaskStrategy;

  /// Action to take if a run with the same parameters already exists.
  ///
  /// Options include 'reject', 'ignore', or 'replace'.
  @JsonKey(name: 'if_not_exists')
  final String ifNotExists;

  /// Optional delay in seconds before starting the run.
  @JsonKey(name: 'after_seconds')
  final int? afterSeconds;

  /// Creates a new configuration for a stateful run.
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

  /// Creates a stateful run configuration from a JSON map.
  factory RunCreateStateful.fromJson(Map<String, dynamic> json) =>
      _$RunCreateStatefulFromJson(json);

  /// Converts this configuration to a JSON map.
  Map<String, dynamic> toJson() => _$RunCreateStatefulToJson(this);
}

/// Parameters for creating a stateless run.
///
/// This class is used to specify the configuration for a new stateless run,
/// which executes a graph without persisting state in a thread.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RunCreateStateless {
  /// Identifier of the assistant to use for this run.
  @JsonKey(name: 'assistant_id')
  final String assistantId;

  /// Input data to provide to the graph for this run.
  final Map<String, dynamic>? input;

  /// Optional command to execute as part of this run.
  final Command? command;

  /// User-provided metadata to associate with this run.
  final Map<String, dynamic>? metadata;

  /// Additional configuration options for this run.
  final Config? config;

  /// Optional webhook URL to receive notifications about run events.
  final String? webhook;

  /// Node(s) to interrupt execution before.
  ///
  /// Can be a string, a list of strings, or null.
  @JsonKey(name: 'interrupt_before')
  final dynamic interruptBefore;

  /// Node(s) to interrupt execution after.
  ///
  /// Can be a string, a list of strings, or null.
  @JsonKey(name: 'interrupt_after')
  final dynamic interruptAfter;

  /// Determines what values are streamed during execution.
  ///
  /// Options include 'values', 'messages', or 'all'.
  @JsonKey(name: 'stream_mode')
  final dynamic streamMode;

  /// Keys to use for feedback in interactive runs.
  @JsonKey(name: 'feedback_keys')
  final List<String>? feedbackKeys;

  /// Whether to stream intermediate values from subgraphs.
  @JsonKey(name: 'stream_subgraphs')
  final bool streamSubgraphs;

  /// Action to take when the run completes.
  ///
  /// Options include 'delete' or 'keep'.
  @JsonKey(name: 'on_completion')
  final String onCompletion;

  /// Action to take when the client disconnects.
  ///
  /// Options include 'cancel', 'keep_going', or 'terminate'.
  @JsonKey(name: 'on_disconnect')
  final String onDisconnect;

  /// Optional delay in seconds before starting the run.
  @JsonKey(name: 'after_seconds')
  final int? afterSeconds;

  /// Creates a new configuration for a stateless run.
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

  /// Creates a stateless run configuration from a JSON map.
  factory RunCreateStateless.fromJson(Map<String, dynamic> json) =>
      _$RunCreateStatelessFromJson(json);

  /// Converts this configuration to a JSON map.
  Map<String, dynamic> toJson() => _$RunCreateStatelessToJson(this);
}
