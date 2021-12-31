import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentProofModel extends Equatable {
  final String? status;
  final String? message;
  final String? data;

  const PaymentProofModel({this.status, this.message, this.data});

  factory PaymentProofModel.fromMap(Map<String, dynamic> data) {
    return PaymentProofModel(
      status: data['status'] as String?,
      message: data['message'] as String?,
      data: data['data'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PaymentProofModel].
  factory PaymentProofModel.fromJson(String data) {
    return PaymentProofModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PaymentProofModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PaymentProofModel copyWith({
    String? status,
    String? message,
    String? data,
  }) {
    return PaymentProofModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
