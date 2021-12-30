import 'dart:convert';

import 'package:equatable/equatable.dart';

class InvoiceData extends Equatable {
  final String? dateNow;
  final String? email;
  final String? iconUrl;
  final String? identityNumber;
  final String? imgUrl;
  final String? isPrivate;
  final String? locationAddress;
  final String? locationName;
  final String? logoUrl;
  final String? name;
  final String? paymentStatus;
  final String? phone;
  final String? price;
  final String? service;
  final String? testDate;
  final String? transactionId;

  const InvoiceData({
    this.dateNow,
    this.email,
    this.iconUrl,
    this.identityNumber,
    this.imgUrl,
    this.isPrivate,
    this.locationAddress,
    this.locationName,
    this.logoUrl,
    this.name,
    this.paymentStatus,
    this.phone,
    this.price,
    this.service,
    this.testDate,
    this.transactionId,
  });

  factory InvoiceData.fromMap(Map<String, dynamic> data) => InvoiceData(
        dateNow: data['date_now'] as String?,
        email: data['email'] as String?,
        iconUrl: data['icon_url'] as String?,
        identityNumber: data['identity_number'] as String?,
        imgUrl: data['img_url'] as String?,
        isPrivate: data['isPrivate'] as String?,
        locationAddress: data['location_address'] as String?,
        locationName: data['location_name'] as String?,
        logoUrl: data['logo_url'] as String?,
        name: data['name'] as String?,
        paymentStatus: data['payment_status'] as String?,
        phone: data['phone'] as String?,
        price: data['price'] as String?,
        service: data['service'] as String?,
        testDate: data['test_date'] as String?,
        transactionId: data['transaction_id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'date_now': dateNow,
        'email': email,
        'icon_url': iconUrl,
        'identity_number': identityNumber,
        'img_url': imgUrl,
        'isPrivate': isPrivate,
        'location_address': locationAddress,
        'location_name': locationName,
        'logo_url': logoUrl,
        'name': name,
        'payment_status': paymentStatus,
        'phone': phone,
        'price': price,
        'service': service,
        'test_date': testDate,
        'transaction_id': transactionId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [InvoiceData].
  factory InvoiceData.fromJson(String data) {
    return InvoiceData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [InvoiceData] to a JSON string.
  String toJson() => json.encode(toMap());

  InvoiceData copyWith({
    String? dateNow,
    String? email,
    String? iconUrl,
    String? identityNumber,
    String? imgUrl,
    String? isPrivate,
    String? locationAddress,
    String? locationName,
    String? logoUrl,
    String? name,
    String? paymentStatus,
    String? phone,
    String? price,
    String? service,
    String? testDate,
    String? transactionId,
  }) {
    return InvoiceData(
      dateNow: dateNow ?? this.dateNow,
      email: email ?? this.email,
      iconUrl: iconUrl ?? this.iconUrl,
      identityNumber: identityNumber ?? this.identityNumber,
      imgUrl: imgUrl ?? this.imgUrl,
      isPrivate: isPrivate ?? this.isPrivate,
      locationAddress: locationAddress ?? this.locationAddress,
      locationName: locationName ?? this.locationName,
      logoUrl: logoUrl ?? this.logoUrl,
      name: name ?? this.name,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      phone: phone ?? this.phone,
      price: price ?? this.price,
      service: service ?? this.service,
      testDate: testDate ?? this.testDate,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  @override
  List<Object?> get props {
    return [
      dateNow,
      email,
      iconUrl,
      identityNumber,
      imgUrl,
      isPrivate,
      locationAddress,
      locationName,
      logoUrl,
      name,
      paymentStatus,
      phone,
      price,
      service,
      testDate,
      transactionId,
    ];
  }
}
