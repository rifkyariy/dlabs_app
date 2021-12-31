import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'medical_history_data.dart';

class MedicalHistoryDatum extends Equatable {
  final int? total;
  final int? activePage;
  final String? showing;
  // final List<int>? pageList;
  final List<MedicalHistoryData>? rows;

  const MedicalHistoryDatum({
    this.total,
    this.activePage,
    this.showing,
    // this.pageList,
    this.rows,
  });

  factory MedicalHistoryDatum.fromMap(Map<String, dynamic> data) =>
      MedicalHistoryDatum(
        total: data['total'] as int?,
        activePage: data['active_page'] as int?,
        showing: data['showing'] as String?,
        // pageList: data['page_list'] as List<int>?,
        rows: (data['rows'] as List<dynamic>?)
            ?.map((e) => MedicalHistoryData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'total': total,
        'active_page': activePage,
        'showing': showing,
        // 'page_list': pageList,
        'rows': rows?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MedicalHistoryDatum].
  factory MedicalHistoryDatum.fromJson(String data) {
    return MedicalHistoryDatum.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MedicalHistoryDatum] to a JSON string.
  String toJson() => json.encode(toMap());

  MedicalHistoryDatum copyWith({
    int? total,
    int? activePage,
    String? showing,
    List<int>? pageList,
    List<MedicalHistoryData>? rows,
  }) {
    return MedicalHistoryDatum(
      total: total ?? this.total,
      activePage: activePage ?? this.activePage,
      showing: showing ?? this.showing,
      // pageList: pageList ?? this.pageList,
      rows: rows ?? this.rows,
    );
  }

  @override
  List<Object?> get props => [
        total,
        activePage,
        showing,
        // pageList,
        rows,
      ];
}
