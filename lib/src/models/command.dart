import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'send.dart';

part 'command.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Command extends Equatable{
  final Map<String, dynamic>? update;
  final dynamic resume;

  @JsonKey(fromJson: _parseSend)
  final dynamic send;

  Command({
    this.update,
    this.resume,
    this.send,
  });

  factory Command.fromJson(Map<String, dynamic> json) => _$CommandFromJson(json);

  Map<String, dynamic> toJson() => _$CommandToJson(this);

  static dynamic _parseSend(dynamic sendData) {
    if (sendData == null) return null;
    if (sendData is List) {
      return sendData.map((item) => Send.fromJson(item)).toList();
    }
    return Send.fromJson(sendData);
  }

  Command copyWith({
    Map<String, dynamic>? update,
    dynamic resume,
    dynamic send,
  }) {
    return Command(
      update: update ?? this.update,
      resume: resume ?? this.resume,
      send: send ?? this.send,
    );
  }

  @override
  List<Object?> get props => [update, resume, send];

  @override
  String toString() {
    return 'Command(update: $update, resume: $resume, send: $send)';
  }
}
