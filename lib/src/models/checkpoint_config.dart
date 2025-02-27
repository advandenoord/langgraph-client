import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

part 'checkpoint_config.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CheckpointConfig extends Equatable{
  @JsonKey(name: 'thread_id')
  final String? threadId;

  @JsonKey(name: 'checkpoint_ns')
  final String? checkpointNs;

  @JsonKey(name: 'checkpoint_id')
  final String? checkpointId;

  @JsonKey(name: 'checkpoint_map')
  final Map<String, dynamic>? checkpointMap;

  CheckpointConfig({
    this.threadId,
    this.checkpointNs,
    this.checkpointId,
    this.checkpointMap,
  });

  factory CheckpointConfig.fromJson(Map<String, dynamic> json) =>
      _$CheckpointConfigFromJson(json);

  Map<String, dynamic> toJson() => _$CheckpointConfigToJson(this);

  CheckpointConfig copyWith({
    String? threadId,
    String? checkpointNs,
    String? checkpointId,
    Map<String, dynamic>? checkpointMap,
  }) {
    return CheckpointConfig(
      threadId: threadId ?? this.threadId,
      checkpointNs: checkpointNs ?? this.checkpointNs,
      checkpointId: checkpointId ?? this.checkpointId,
      checkpointMap: checkpointMap ?? this.checkpointMap,
    );
  }

  @override
  List<Object?> get props => [threadId, checkpointNs, checkpointId, checkpointMap];

  @override
  String toString() {
    return 'CheckpointConfig('
        'threadId: $threadId, '
        'checkpointNs: $checkpointNs, '
        'checkpointId: $checkpointId, '
        'checkpointMap: $checkpointMap)';
  }
}
