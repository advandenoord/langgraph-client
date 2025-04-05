import 'package:json_annotation/json_annotation.dart';

part 'assistant.g.dart';

/// Represents a LangGraph assistant, which is a configurable instance of a graph
/// that can be used to process messages in threads.
///
/// An assistant is associated with a specific graph and includes configuration
/// options that determine how the graph will process inputs.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Assistant {
  /// Unique identifier for the assistant.
  @JsonKey(name: 'assistant_id')
  final String assistantId;

  /// Identifier of the graph associated with this assistant.
  @JsonKey(name: 'graph_id')
  final String graphId;

  /// Configuration options for how the assistant operates.
  final AssistantConfig config;

  /// Timestamp when the assistant was created.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Timestamp when the assistant was last updated.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// User-provided metadata associated with this assistant.
  ///
  /// Can be used for storing custom information or for filtering assistants.
  final Map<String, dynamic> metadata;

  /// Optional version number for the assistant.
  final int? version;

  /// Optional human-readable name for the assistant.
  final String? name;

  /// Creates a new assistant instance.
  Assistant({
    required this.assistantId,
    required this.graphId,
    required this.config,
    required this.createdAt,
    required this.updatedAt,
    required this.metadata,
    this.version,
    this.name,
  });

  /// Creates an assistant from a JSON map.
  factory Assistant.fromJson(Map<String, dynamic> json) =>
      _$AssistantFromJson(json);

  /// Converts this assistant to a JSON map.
  Map<String, dynamic> toJson() => _$AssistantToJson(this);
}

/// Configuration options for a LangGraph assistant.
///
/// This class contains parameters that control how an assistant
/// processes messages and manages graph execution.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssistantConfig {
  /// Optional tags that can be used to categorize or filter assistants.
  final List<String>? tags;

  /// Maximum recursion depth for graph execution, used to prevent infinite loops.
  @JsonKey(name: 'recursion_limit')
  final int? recursionLimit;

  /// Custom configuration options for the graph execution.
  ///
  /// This map can contain any additional configuration parameters
  /// specific to the graph implementation.
  final Map<String, dynamic>? configurable;

  /// Creates a new assistant configuration.
  AssistantConfig({
    this.tags,
    this.recursionLimit,
    this.configurable,
  });

  /// Creates an assistant configuration from a JSON map.
  factory AssistantConfig.fromJson(Map<String, dynamic> json) =>
      _$AssistantConfigFromJson(json);

  /// Converts this configuration to a JSON map.
  Map<String, dynamic> toJson() => _$AssistantConfigToJson(this);
}
