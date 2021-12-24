import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'trx_detail_patient_list.dart';
import 'trx_detail_tracking_list.dart';

class TrxDetailData extends Equatable {
  final String? transactionId;
  final int? lastTrackingStatus;
  final String? transactionDate;
  final String? testPurpose;
  final String? services;
  final String? masterMedicalKitNama;
  final String? myself;
  final String? identityNumber;
  final String? name;
  final String? email;
  final String? phone;
  final String? testDate;
  final String? locationName;
  final String? locationAddress;
  final int? price;
  final String? isPrivate;
  final String? cancelDate;
  final String? groupId;
  final String? createdBy;
  final String? createdDate;
  final String? updatedDate;
  final List<TrxDetailPatientList>? patientList;
  final List<TrxDetailTrackingList>? trackingList;

  const TrxDetailData({
    this.transactionId,
    this.lastTrackingStatus,
    this.transactionDate,
    this.testPurpose,
    this.services,
    this.masterMedicalKitNama,
    this.myself,
    this.identityNumber,
    this.name,
    this.email,
    this.phone,
    this.testDate,
    this.locationName,
    this.locationAddress,
    this.price,
    this.isPrivate,
    this.cancelDate,
    this.groupId,
    this.createdBy,
    this.createdDate,
    this.updatedDate,
    this.patientList,
    this.trackingList,
  });

  factory TrxDetailData.fromMap(Map<String, dynamic> data) => TrxDetailData(
        transactionId: data['transaction_id'] as String?,
        lastTrackingStatus: data['last_tracking_status'] as int?,
        transactionDate: data['transaction_date'] as String?,
        testPurpose: data['test_purpose'] as String?,
        services: data['services'] as String?,
        masterMedicalKitNama: data['master_medical_kit_nama'] as String?,
        myself: data['myself'] as String?,
        identityNumber: data['identity_number'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        testDate: data['test_date'] as String?,
        locationName: data['location_name'] as String?,
        locationAddress: data['location_address'] as String?,
        price: data['price'] as int?,
        isPrivate: data['isPrivate'] as String?,
        cancelDate: data['cancel_date'] as String?,
        groupId: data['group_id'] as String?,
        createdBy: data['created_by'] as String?,
        createdDate: data['created_date'] as String?,
        updatedDate: data['updated_date'] as String?,
        patientList: (data['patient_list'] as List<dynamic>?)
            ?.map(
                (e) => TrxDetailPatientList.fromMap(e as Map<String, dynamic>))
            .toList(),
        trackingList: (data['tracking_list'] as List<dynamic>?)
            ?.map(
                (e) => TrxDetailTrackingList.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'transaction_id': transactionId,
        'last_tracking_status': lastTrackingStatus,
        'transaction_date': transactionDate,
        'test_purpose': testPurpose,
        'services': services,
        'master_medical_kit_nama': masterMedicalKitNama,
        'myself': myself,
        'identity_number': identityNumber,
        'name': name,
        'email': email,
        'phone': phone,
        'test_date': testDate,
        'location_name': locationName,
        'location_address': locationAddress,
        'price': price,
        'isPrivate': isPrivate,
        'cancel_date': cancelDate,
        'group_id': groupId,
        'created_by': createdBy,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'patient_list': patientList?.map((e) => e.toMap()).toList(),
        'tracking_list': trackingList?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TrxDetailData].
  factory TrxDetailData.fromJson(String data) {
    return TrxDetailData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TrxDetailData] to a JSON string.
  String toJson() => json.encode(toMap());

  TrxDetailData copyWith({
    String? transactionId,
    int? lastTrackingStatus,
    String? transactionDate,
    String? testPurpose,
    String? services,
    String? masterMedicalKitNama,
    String? myself,
    String? identityNumber,
    String? name,
    String? email,
    String? phone,
    String? testDate,
    String? locationName,
    String? locationAddress,
    int? price,
    String? isPrivate,
    String? cancelDate,
    String? groupId,
    String? createdBy,
    String? createdDate,
    String? updatedDate,
    List<TrxDetailPatientList>? patientList,
    List<TrxDetailTrackingList>? trackingList,
  }) {
    return TrxDetailData(
      transactionId: transactionId ?? this.transactionId,
      lastTrackingStatus: lastTrackingStatus ?? this.lastTrackingStatus,
      transactionDate: transactionDate ?? this.transactionDate,
      testPurpose: testPurpose ?? this.testPurpose,
      services: services ?? this.services,
      masterMedicalKitNama: masterMedicalKitNama ?? this.masterMedicalKitNama,
      myself: myself ?? this.myself,
      identityNumber: identityNumber ?? this.identityNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      testDate: testDate ?? this.testDate,
      locationName: locationName ?? this.locationName,
      locationAddress: locationAddress ?? this.locationAddress,
      price: price ?? this.price,
      isPrivate: isPrivate ?? this.isPrivate,
      cancelDate: cancelDate ?? this.cancelDate,
      groupId: groupId ?? this.groupId,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      patientList: patientList ?? this.patientList,
      trackingList: trackingList ?? this.trackingList,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      transactionId,
      lastTrackingStatus,
      transactionDate,
      testPurpose,
      services,
      masterMedicalKitNama,
      myself,
      identityNumber,
      name,
      email,
      phone,
      testDate,
      locationName,
      locationAddress,
      price,
      isPrivate,
      cancelDate,
      groupId,
      createdBy,
      createdDate,
      updatedDate,
      patientList,
      trackingList,
    ];
  }
}
