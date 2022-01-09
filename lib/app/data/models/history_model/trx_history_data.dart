import 'dart:convert';

import 'package:kayabe_lims/app/data/models/trx_history_model/trx_history_row.dart';
import 'package:equatable/equatable.dart';

class HistoryData extends Equatable {
  final int? total;
  final int? activePage;
  final String? showing;
  final List<dynamic>? pageList;
  final List<TrxHistoryRow>? rows;

  const HistoryData({
    this.total,
    this.activePage,
    this.showing,
    this.pageList,
    this.rows,
  });

  factory HistoryData.fromMap(Map<String, dynamic> data) => HistoryData(
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
  /// Parses the string and returns the resulting Json object as [HistoryData].
  factory HistoryData.fromJson(String data) {
    return HistoryData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HistoryData] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [total, activePage, showing, pageList, rows];
}
