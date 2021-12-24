import 'dart:convert';

import 'package:equatable/equatable.dart';

class TrxDetailPatientList extends Equatable {
  final int? id;
  final String? transactionId;
  final String? testTypeText;
  final String? fullName;
  final String? email;
  final String? identityNumber;
  final String? phone;
  final String? birthDate;
  final String? gender;
  final String? address;
  final String? nationality;
  final String? arrivedDate;
  final String? createdDate;

  const TrxDetailPatientList({
    this.id,
    this.transactionId,
    this.testTypeText,
    this.fullName,
    this.email,
    this.identityNumber,
    this.phone,
    this.birthDate,
    this.gender,
    this.address,
    this.nationality,
    this.arrivedDate,
    this.createdDate,
  });

  factory TrxDetailPatientList.fromMap(Map<String, dynamic> data) =>
      TrxDetailPatientList(
        id: data['id'] as int?,
        transactionId: data['transaction_id'] as String?,
        testTypeText: data['test_type_text'] as String?,
        fullName: data['full_name'] as String?,
        email: data['email'] as String?,
        identityNumber: data['identity_number'] as String?,
        phone: data['phone'] as String?,
        birthDate: data['birth_date'] as String?,
        gender: data['gender'] as String?,
        address: data['address'] as String?,
        nationality: data['nationality'] as String?,
        arrivedDate: data['arrived_date'] as String?,
        createdDate: data['created_date'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'transaction_id': transactionId,
        'test_type_text': testTypeText,
        'full_name': fullName,
        'email': email,
        'identity_number': identityNumber,
        'phone': phone,
        'birth_date': birthDate,
        'gender': gender,
        'address': address,
        'nationality': nationality,
        'arrived_date': arrivedDate,
        'created_date': createdDate,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TrxDetailPatientList].
  factory TrxDetailPatientList.fromJson(String data) {
    return TrxDetailPatientList.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TrxDetailPatientList] to a JSON string.
  String toJson() => json.encode(toMap());

  TrxDetailPatientList copyWith({
    int? id,
    String? transactionId,
    String? testTypeText,
    String? fullName,
    String? email,
    String? identityNumber,
    String? phone,
    String? birthDate,
    String? gender,
    String? address,
    String? nationality,
    String? arrivedDate,
    String? createdDate,
  }) {
    return TrxDetailPatientList(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      testTypeText: testTypeText ?? this.testTypeText,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      identityNumber: identityNumber ?? this.identityNumber,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      nationality: nationality ?? this.nationality,
      arrivedDate: arrivedDate ?? this.arrivedDate,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      transactionId,
      testTypeText,
      fullName,
      email,
      identityNumber,
      phone,
      birthDate,
      gender,
      address,
      nationality,
      arrivedDate,
      createdDate,
    ];
  }
}
