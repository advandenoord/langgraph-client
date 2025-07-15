// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreItem _$StoreItemFromJson(Map<String, dynamic> json) => StoreItem(
      namespace:
          (json['namespace'] as List<dynamic>).map((e) => e as String).toList(),
      id: json['id'] as String,
      data: json['data'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$StoreItemToJson(StoreItem instance) => <String, dynamic>{
      'namespace': instance.namespace,
      'id': instance.id,
      'data': instance.data,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      if (instance.metadata case final value?) 'metadata': value,
    };

StoreItemCreate _$StoreItemCreateFromJson(Map<String, dynamic> json) =>
    StoreItemCreate(
      namespace:
          (json['namespace'] as List<dynamic>).map((e) => e as String).toList(),
      id: json['id'] as String,
      data: json['data'] as Map<String, dynamic>,
      metadata: json['metadata'] as Map<String, dynamic>?,
      ifExists: json['if_exists'] as String? ?? 'raise',
    );

Map<String, dynamic> _$StoreItemCreateToJson(StoreItemCreate instance) =>
    <String, dynamic>{
      'namespace': instance.namespace,
      'id': instance.id,
      'data': instance.data,
      if (instance.metadata case final value?) 'metadata': value,
      'if_exists': instance.ifExists,
    };

StoreItemSearch _$StoreItemSearchFromJson(Map<String, dynamic> json) =>
    StoreItemSearch(
      namespace:
          (json['namespace'] as List<dynamic>).map((e) => e as String).toList(),
      filter: json['filter'] as Map<String, dynamic>?,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$StoreItemSearchToJson(StoreItemSearch instance) =>
    <String, dynamic>{
      'namespace': instance.namespace,
      if (instance.filter case final value?) 'filter': value,
      'limit': instance.limit,
      'offset': instance.offset,
    };
