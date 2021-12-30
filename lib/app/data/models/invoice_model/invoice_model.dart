import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'invoice_data.dart';

class InvoiceModel extends Equatable {
  final String? status;
  final String? message;
  final InvoiceData? data;

  const InvoiceModel({this.status, this.message, this.data});

  factory InvoiceModel.fromMap(Map<String, dynamic> data) => InvoiceModel(
        status: data['status'] as String?,
        message: data['message'] as String?,
        data: data['data'] == null
            ? null
            : InvoiceData.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [InvoiceModel].
  factory InvoiceModel.fromJson(String data) {
    return InvoiceModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [InvoiceModel] to a JSON string.
  String toJson() => json.encode(toMap());

  InvoiceModel copyWith({
    String? status,
    String? message,
    InvoiceData? data,
  }) {
    return InvoiceModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
