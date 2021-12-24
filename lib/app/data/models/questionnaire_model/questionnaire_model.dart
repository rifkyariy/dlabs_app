import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'questionnaire_data_model.dart';

class QuestionnaireModel extends Equatable {
  final String? status;
  final String? message;
  final List<QuestionnaireDataModel>? data;

  const QuestionnaireModel({this.status, this.message, this.data});

  factory QuestionnaireModel.fromMap(Map<String, dynamic> data) {
    return QuestionnaireModel(
      status: data['status'] as String?,
      message: data['message'] as String?,
      data: (data['data'] as List<dynamic>?)
          ?.map(
              (e) => QuestionnaireDataModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuestionnaireModel].
  factory QuestionnaireModel.fromJson(String data) {
    return QuestionnaireModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuestionnaireModel] to a JSON string.
  String toJson() => json.encode(toMap());

  QuestionnaireModel copyWith({
    String? status,
    String? message,
    List<QuestionnaireDataModel>? data,
  }) {
    return QuestionnaireModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
