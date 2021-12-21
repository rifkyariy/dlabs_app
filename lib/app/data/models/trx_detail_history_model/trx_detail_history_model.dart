import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'trx_detail_data.dart';

class TrxDetailHistoryModel extends Equatable {
  final String? status;
  final String? message;
  final TrxDetailData? data;

  const TrxDetailHistoryModel({this.status, this.message, this.data});

  factory TrxDetailHistoryModel.fromMap(Map<String, dynamic> data) {
    return TrxDetailHistoryModel(
      status: data['status'] as String?,
      message: data['message'] as String?,
      data: data['data'] == null
          ? null
          : TrxDetailData.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TrxDetailHistoryModel].
  factory TrxDetailHistoryModel.fromJson(String data) {
    return TrxDetailHistoryModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TrxDetailHistoryModel] to a JSON string.
  String toJson() => json.encode(toMap());

  TrxDetailHistoryModel copyWith({
    String? status,
    String? message,
    TrxDetailData? data,
  }) {
    return TrxDetailHistoryModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, message, data];
}
