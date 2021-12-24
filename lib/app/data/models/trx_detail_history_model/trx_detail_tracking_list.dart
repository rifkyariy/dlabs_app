import 'dart:convert';

import 'package:equatable/equatable.dart';

class TrxDetailTrackingList extends Equatable {
  final String? transactionId;
  final String? picName;
  final String? status;
  final String? message;
  final String? reasonsText;
  final String? createdDate;
  final String? updatedDate;

  const TrxDetailTrackingList({
    this.transactionId,
    this.picName,
    this.status,
    this.message,
    this.reasonsText,
    this.createdDate,
    this.updatedDate,
  });

  factory TrxDetailTrackingList.fromMap(Map<String, dynamic> data) =>
      TrxDetailTrackingList(
        transactionId: data['transaction_id'] as String?,
        picName: data['pic_name'] as String?,
        status: data['status'] as String?,
        message: data['message'] as String?,
        reasonsText: data['reasons_text'] as String?,
        createdDate: data['created_date'] as String?,
        updatedDate: data['updated_date'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'transaction_id': transactionId,
        'pic_name': picName,
        'status': status,
        'message': message,
        'reasons_text': reasonsText,
        'created_date': createdDate,
        'updated_date': updatedDate,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TrxDetailTrackingList].
  factory TrxDetailTrackingList.fromJson(String data) {
    return TrxDetailTrackingList.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TrxDetailTrackingList] to a JSON string.
  String toJson() => json.encode(toMap());

  TrxDetailTrackingList copyWith({
    String? transactionId,
    String? picName,
    String? status,
    String? message,
    String? reasonsText,
    String? createdDate,
    String? updatedDate,
  }) {
    return TrxDetailTrackingList(
      transactionId: transactionId ?? this.transactionId,
      picName: picName ?? this.picName,
      status: status ?? this.status,
      message: message ?? this.message,
      reasonsText: reasonsText ?? this.reasonsText,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      transactionId,
      picName,
      status,
      message,
      reasonsText,
      createdDate,
      updatedDate,
    ];
  }
}
