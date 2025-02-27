import 'package:json_annotation/json_annotation.dart';

part 'assistant.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Assistant {
  @JsonKey(name: 'assistant_id')
  final String assistantId;

  @JsonKey(name: 'graph_id')
  final String graphId;

  final AssistantConfig config;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final Map<String, dynamic> metadata;

  final int? version;

  final String? name;

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

  factory Assistant.fromJson(Map<String, dynamic> json) => _$AssistantFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssistantConfig {
  final List<String>? tags;

  @JsonKey(name: 'recursion_limit')
  final int? recursionLimit;

  final Map<String, dynamic>? configurable;

  AssistantConfig({
    this.tags,
    this.recursionLimit,
    this.configurable,
  });

  factory AssistantConfig.fromJson(Map<String, dynamic> json) => _$AssistantConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantConfigToJson(this);
}
