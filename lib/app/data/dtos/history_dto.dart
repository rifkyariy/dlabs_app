import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class HistoryDto {
  final int? page;
  final int? maxRows;
  final String? orderBy;
  final String? orderType;
  final List<SearchDto>? search;

  const HistoryDto({
    this.page,
    this.maxRows,
    this.orderBy,
    this.orderType,
    this.search,
  });

  factory HistoryDto.fromMap(Map<String, dynamic> data) => HistoryDto(
        page: data['page'] as int?,
        maxRows: data['max_rows'] as int?,
        orderBy: data['order_by'] as String?,
        orderType: data['order_type'] as String?,
        search: (data['search'] as List<dynamic>?)
            ?.map((e) => SearchDto.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'page': page,
        'max_rows': maxRows,
        'order_by': orderBy,
        'order_type': orderType,
        'search': search?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HistoryDto].
  factory HistoryDto.fromJson(String data) {
    return HistoryDto.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HistoryDto] to a JSON string.
  String toJson() => json.encode(toMap());
}

@immutable
class SearchDto {
  final String? value;

  const SearchDto({this.value});

  factory SearchDto.fromMap(Map<String, dynamic> data) => SearchDto(
        value: data['value'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'value': value,
      };
}
