import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Send extends Equatable {
  final String node;
  final Map<String, dynamic> input;

  Send({
    required this.node,
    required this.input,
  });

  factory Send.fromJson(Map<String, dynamic> json) => _$SendFromJson(json);

  Map<String, dynamic> toJson() => _$SendToJson(this);

  @override
  List<Object?> get props => [node, input];

  @override
  String toString() => 'Send(node: $node, input: $input)';
}
