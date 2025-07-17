import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

/// Represents an item stored in LangGraph Store.
///
/// Store items can be any type of data and are organized under namespaces.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class StoreItem {
  /// The namespace this item belongs to.
  final List<String> namespace;

  /// The unique identifier of this item within its namespace.
  final String key;

  /// The data stored in this item.
  final Map<String, dynamic> data;

  /// Timestamp when this item was created.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Timestamp when this item was last updated.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// Optional metadata associated with this item.
  final Map<String, dynamic>? metadata;

  /// Creates a new store item instance.
  StoreItem({
    required this.namespace,
    required this.key,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
    this.metadata,
  });

  /// Creates a store item from a JSON map.
  factory StoreItem.fromJson(Map<String, dynamic> json) =>
      _$StoreItemFromJson(json);

  /// Converts this store item to a JSON map.
  Map<String, dynamic> toJson() => _$StoreItemToJson(this);
}

/// Request to create or update a store item.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class StoreItemCreate {
  /// The namespace for this item.
  final List<String> namespace;

  /// The unique identifier for this item within its namespace.
  final String key;

  /// The data to store in this item.
  final Map<String, dynamic> data;

  /// Optional metadata to associate with this item.
  final Map<String, dynamic>? metadata;

  /// How to handle existing items with the same KEY (default: 'raise').
  ///
  /// Options are 'raise', 'update', or 'ignore'.
  @JsonKey(name: 'if_exists')
  final String ifExists;

  /// Creates a new store item creation request.
  StoreItemCreate({
    required this.namespace,
    required this.key,
    required this.data,
    this.metadata,
    this.ifExists = 'raise',
  });

  /// Creates a store item creation request from a JSON map.
  factory StoreItemCreate.fromJson(Map<String, dynamic> json) =>
      _$StoreItemCreateFromJson(json);

  /// Converts this request to a JSON map.
  Map<String, dynamic> toJson() => _$StoreItemCreateToJson(this);
}

/// Search parameters for querying store items.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class StoreItemSearch {
  /// The namespace to search in.
  @JsonKey(name: 'namespace_prefix')
  final List<String> namespacePrefix;

  /// Optional metadata filter to match against item metadata.
  final Map<String, dynamic>? filter;

  /// Optional query string for semantic/vector search.
  final String? query;

  /// Maximum number of results to return.
  final int limit;

  /// Number of results to skip for pagination.
  final int offset;

  /// Creates a new store item search request.
  StoreItemSearch({
    required this.namespacePrefix,
    this.filter,
    this.limit = 10,
    this.offset = 0,
    this.query,
  });

  /// Creates a store item search request from a JSON map.
  factory StoreItemSearch.fromJson(Map<String, dynamic> json) =>
      _$StoreItemSearchFromJson(json);

  /// Converts this request to a JSON map.
  Map<String, dynamic> toJson() => _$StoreItemSearchToJson(this);
}
