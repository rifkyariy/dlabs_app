import 'dart:convert';

import 'package:equatable/equatable.dart';

class TrxHistoryRow extends Equatable {
  final String? transactionId;
  final String? transactionDate;
  final int? lastTrackingStatus;
  final String? serviceType;
  final String? services;
  final String? identityNumber;
  final String? testDate;
  final String? locationName;
  final String? locationAddress;
  final String? price;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? statusText;

  const TrxHistoryRow({
    this.transactionId,
    this.transactionDate,
    this.lastTrackingStatus,
    this.serviceType,
    this.services,
    this.identityNumber,
    this.testDate,
    this.locationName,
    this.locationAddress,
    this.price,
    this.fullName,
    this.phone,
    this.email,
    this.statusText,
  });

  factory TrxHistoryRow.fromMap(Map<String, dynamic> data) => TrxHistoryRow(
        transactionId: data['transaction_id'] as String?,
        transactionDate: data['transaction_date'] as String?,
        lastTrackingStatus: data['last_tracking_status'] as int?,
        serviceType: data['service_type'] as String?,
        services: data['services'] as String?,
        identityNumber: data['identity_number'] as String?,
        testDate: data['test_date'] as String?,
        locationName: data['location_name'] as String?,
        locationAddress: data['location_address'] as String?,
        price: data['price'] as String?,
        fullName: data['full_name'] as String?,
        phone: data['phone'] as String?,
        email: data['email'] as String?,
        statusText: data['status_text'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'transaction_id': transactionId,
        'transaction_date': transactionDate,
        'last_tracking_status': lastTrackingStatus,
        'service_type': serviceType,
        'services': services,
        'identity_number': identityNumber,
        'test_date': testDate,
        'location_name': locationName,
        'location_address': locationAddress,
        'price': price,
        'full_name': fullName,
        'phone': phone,
        'email': email,
        'status_text': statusText,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TrxHistoryRow].
  factory TrxHistoryRow.fromJson(String data) {
    return TrxHistoryRow.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TrxHistoryRow] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      transactionId,
      transactionDate,
      lastTrackingStatus,
      serviceType,
      services,
      identityNumber,
      testDate,
      locationName,
      locationAddress,
      price,
      fullName,
      phone,
      email,
      statusText,
    ];
  }
}
