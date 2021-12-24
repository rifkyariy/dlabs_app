import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'trx_history_data.dart';

class TrxHistoryModel extends Equatable {
  final String? status;
  final String? message;
  final TrxHistoryData? data;

  const TrxHistoryModel({this.status, this.message, this.data});

  factory TrxHistoryModel.fromMap(Map<String, dynamic> data) => TrxHistoryModel(
        status: data['status'] as String?,
        message: data['message'] as String?,
        data: data['data'] == null
            ? null
            : TrxHistoryData.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TrxHistoryModel].
  factory TrxHistoryModel.fromJson(String data) {
    return TrxHistoryModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TrxHistoryModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [status, message, data];
}
