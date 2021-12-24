import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'trx_history_row.dart';

class TrxHistoryData extends Equatable {
  final int? total;
  final int? activePage;
  final String? showing;
  final List<dynamic>? pageList;
  final List<TrxHistoryRow>? rows;

  const TrxHistoryData({
    this.total,
    this.activePage,
    this.showing,
    this.pageList,
    this.rows,
  });

  factory TrxHistoryData.fromMap(Map<String, dynamic> data) => TrxHistoryData(
        total: data['total'] as int?,
        activePage: data['active_page'] as int?,
        showing: data['showing'] as String?,
        pageList: data['page_list'] as dynamic,
        rows: (data['rows'] as List<dynamic>?)
            ?.map((e) => TrxHistoryRow.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'total': total,
        'active_page': activePage,
        'showing': showing,
        'page_list': pageList,
        'rows': rows?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TrxHistoryData].
  factory TrxHistoryData.fromJson(String data) {
    return TrxHistoryData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TrxHistoryData] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [total, activePage, showing, pageList, rows];
}
