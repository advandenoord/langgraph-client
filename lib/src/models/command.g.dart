// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) => Command(
      update: json['update'] as Map<String, dynamic>?,
      resume: json['resume'],
      send: Command._parseSend(json['send']),
    );

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
      if (instance.update case final value?) 'update': value,
      if (instance.resume case final value?) 'resume': value,
      if (instance.send case final value?) 'send': value,
    };
