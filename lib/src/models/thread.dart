import 'package:json_annotation/json_annotation.dart';
import 'checkpoint_config.dart';

part 'thread.g.dart';

/// Represents a LangGraph thread, which is a container for persistent state and message history.
///
/// A thread maintains state across multiple runs of a graph, allowing for
/// conversational interactions or stateful processing across multiple invocations.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Thread {
  /// Unique identifier for the thread.
  @JsonKey(name: 'thread_id')
  final String threadId;

  /// Timestamp when the thread was created.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Timestamp when the thread was last updated.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// User-provided metadata associated with this thread.
  ///
  /// Can be used for storing custom information or for filtering threads.
  final Map<String, dynamic> metadata;

  /// Current status of the thread (e.g., 'active', 'completed', 'error').
  final String status;

  /// The current state values stored in this thread.
  final Map<String, dynamic>? values;

  /// Creates a new thread instance.
  Thread({
    required this.threadId,
    required this.createdAt,
    required this.updatedAt,
    required this.metadata,
    required this.status,
    this.values,
  });

  /// Creates a thread from a JSON map.
  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);

  /// Converts this thread to a JSON map.
  Map<String, dynamic> toJson() => _$ThreadToJson(this);
}

/// Represents the state of a thread at a specific point in time.
///
/// Thread state includes the values stored in the thread, information about
/// next steps in the graph execution, and any running tasks.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ThreadState {
  /// The values stored in this thread state.
  ///
  /// This contains the actual data that represents the state of the graph execution.
  final dynamic values;

  /// List of next node names to execute in the graph.
  final List<String> next;

  /// List of tasks that are currently running or scheduled in this thread.
  final List<TaskState> tasks;

  /// Configuration for the checkpoint that this thread state represents.
  final CheckpointConfig checkpoint;

  /// User-provided metadata associated with this thread state.
  final Map<String, dynamic> metadata;

  /// Timestamp when this thread state was created.
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// Reference to the parent checkpoint if this state is derived from another.
  @JsonKey(name: 'parent_checkpoint')
  final Map<String, dynamic>? parentCheckpoint;

  /// Creates a new thread state instance.
  ThreadState({
    required this.values,
    required this.next,
    required this.tasks,
    required this.checkpoint,
    required this.metadata,
    required this.createdAt,
    this.parentCheckpoint,
  });

  /// Creates a thread state from a JSON map.
  factory ThreadState.fromJson(Map<String, dynamic> json) =>
      _$ThreadStateFromJson(json);

  /// Converts this thread state to a JSON map.
  Map<String, dynamic> toJson() => _$ThreadStateToJson(this);
}

/// Represents a task running within a thread.
///
/// Tasks are typically background jobs or processes that are executing
/// as part of a graph run on a thread.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TaskState {
  /// Unique identifier for the task.
  final String id;

  /// Name of the task, typically the node name in the graph.
  final String name;

  /// Error message if the task failed, null otherwise.
  final String? error;

  /// List of interrupt points for this task.
  final List<dynamic>? interrupts;

  /// Configuration for the checkpoint associated with this task.
  final CheckpointConfig? checkpoint;

  /// The thread state associated with this task, if applicable.
  final ThreadState? state;

  /// Creates a new task state instance.
  TaskState({
    required this.id,
    required this.name,
    this.error,
    this.interrupts,
    this.checkpoint,
    this.state,
  });

  /// Creates a task state from a JSON map.
  factory TaskState.fromJson(Map<String, dynamic> json) =>
      _$TaskStateFromJson(json);

  /// Converts this task state to a JSON map.
  Map<String, dynamic> toJson() => _$TaskStateToJson(this);
}
