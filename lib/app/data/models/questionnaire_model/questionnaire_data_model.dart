import 'dart:convert';

import 'package:equatable/equatable.dart';

class QuestionnaireDataModel extends Equatable {
  final String? questionnaire;
  final String? jawaban;

  const QuestionnaireDataModel({this.questionnaire, this.jawaban});

  factory QuestionnaireDataModel.fromMap(Map<String, dynamic> data) =>
      QuestionnaireDataModel(
        questionnaire: data['questionnaire'] as String?,
        jawaban: data['jawaban'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'questionnaire': questionnaire,
        'jawaban': jawaban,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuestionnaireDataModel].
  factory QuestionnaireDataModel.fromJson(String data) {
    return QuestionnaireDataModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuestionnaireDataModel] to a JSON string.
  String toJson() => json.encode(toMap());

  QuestionnaireDataModel copyWith({
    String? questionnaire,
    String? jawaban,
  }) {
    return QuestionnaireDataModel(
      questionnaire: questionnaire ?? this.questionnaire,
      jawaban: jawaban ?? this.jawaban,
    );
  }

  @override
  List<Object?> get props => [questionnaire, jawaban];
}
