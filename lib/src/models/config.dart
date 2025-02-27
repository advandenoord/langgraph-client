import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Config extends Equatable {
  final List<String>? tags;

  @JsonKey(name: 'recursion_limit')
  final int? recursionLimit;

  final Map<String, dynamic>? configurable;

  Config({
    this.tags,
    this.recursionLimit,
    this.configurable,
  });

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);

  Config copyWith({
    List<String>? tags,
    int? recursionLimit,
    Map<String, dynamic>? configurable,
  }) {
    return Config(
      tags: tags ?? this.tags,
      recursionLimit: recursionLimit ?? this.recursionLimit,
      configurable: configurable ?? this.configurable,
    );
  }

  @override
  List<Object?> get props => [tags, recursionLimit, configurable];

  @override
  String toString() {
    return 'Config(tags: $tags, recursionLimit: $recursionLimit, configurable: $configurable)';
  }
}
