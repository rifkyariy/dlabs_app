import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'medical_history_datum.dart';

class MedicalHistoryModel extends Equatable {
  final String? status;
  final String? message;
  final MedicalHistoryDatum? data;

  const MedicalHistoryModel({this.status, this.message, this.data});

  factory MedicalHistoryModel.fromMap(Map<String, dynamic> data) {
    return MedicalHistoryModel(
      status: data['status'] as String?,
      message: data['message'] as String?,
      data: data['data'] == null
          ? null
          : MedicalHistoryDatum.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MedicalHistoryModel].
  factory MedicalHistoryModel.fromJson(String data) {
    return MedicalHistoryModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MedicalHistoryModel] to a JSON string.
  String toJson() => json.encode(toMap());

  MedicalHistoryModel copyWith({
    String? status,
    String? message,
    MedicalHistoryDatum? data,
  }) {
    return MedicalHistoryModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
