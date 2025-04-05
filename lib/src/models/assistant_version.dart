import 'package:json_annotation/json_annotation.dart';
import 'assistant.dart';

part 'assistant_version.g.dart';

/// Represents a specific version of an assistant.
///
/// Assistant versions allow tracking changes to assistant configurations over time.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssistantVersion {
  /// Unique identifier for the assistant.
  @JsonKey(name: 'assistant_id')
  final String assistantId;

  /// The version number of this assistant configuration.
  final int version;

  /// The graph ID associated with this assistant version.
  @JsonKey(name: 'graph_id')
  final String graphId;

  /// Configuration options for this assistant version.
  final AssistantConfig config;

  /// Timestamp when this assistant version was created.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// User-provided metadata associated with this assistant version.
  final Map<String, dynamic> metadata;

  /// Optional human-readable name for the assistant.
  final String? name;

  /// Creates a new assistant version instance.
  AssistantVersion({
    required this.assistantId,
    required this.version,
    required this.graphId,
    required this.config,
    required this.createdAt,
    required this.metadata,
    this.name,
  });

  /// Creates an assistant version from a JSON map.
  factory AssistantVersion.fromJson(Map<String, dynamic> json) =>
      _$AssistantVersionFromJson(json);

  /// Converts this assistant version to a JSON map.
  Map<String, dynamic> toJson() => _$AssistantVersionToJson(this);
}

/// Response containing a list of assistant versions.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssistantVersionList {
  /// List of assistant versions.
  final List<AssistantVersion> versions;

  /// Creates a new assistant version list.
  AssistantVersionList({
    required this.versions,
  });

  /// Creates an assistant version list from a JSON map.
  factory AssistantVersionList.fromJson(Map<String, dynamic> json) =>
      _$AssistantVersionListFromJson(json);

  /// Converts this list to a JSON map.
  Map<String, dynamic> toJson() => _$AssistantVersionListToJson(this);
}

/// Represents schema information for an assistant.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssistantSchema {
  /// Input schema for the assistant.
  final Map<String, dynamic>? input;

  /// Output schema for the assistant.
  final Map<String, dynamic>? output;

  /// Creates a new assistant schema instance.
  AssistantSchema({
    this.input,
    this.output,
  });

  /// Creates an assistant schema from a JSON map.
  factory AssistantSchema.fromJson(Map<String, dynamic> json) =>
      _$AssistantSchemaFromJson(json);

  /// Converts this schema to a JSON map.
  Map<String, dynamic> toJson() => _$AssistantSchemaToJson(this);
}

/// Represents a subgraph definition for an assistant.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssistantSubgraph {
  /// The namespace for this subgraph.
  final String namespace;

  /// The definition of the subgraph structure.
  final Map<String, dynamic> graph;

  /// Creates a new assistant subgraph instance.
  AssistantSubgraph({
    required this.namespace,
    required this.graph,
  });

  /// Creates an assistant subgraph from a JSON map.
  factory AssistantSubgraph.fromJson(Map<String, dynamic> json) =>
      _$AssistantSubgraphFromJson(json);

  /// Converts this subgraph to a JSON map.
  Map<String, dynamic> toJson() => _$AssistantSubgraphToJson(this);
}
