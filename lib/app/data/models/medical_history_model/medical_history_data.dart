import 'dart:convert';

import 'package:equatable/equatable.dart';

class MedicalHistoryData extends Equatable {
  final int? barcodeValue;
  final String? sampleId;
  final String? identityNumber;
  final String? transactionId;
  final int? status;
  final String? statusText;
  final String? statusMessage;
  final String? sampleType;
  final String? labProcess;
  final String? result;
  final String? noteResult;
  final int? testTypeId;
  final String? testTypeText;
  final String? sampleFile;

  const MedicalHistoryData({
    this.barcodeValue,
    this.sampleId,
    this.identityNumber,
    this.transactionId,
    this.status,
    this.statusText,
    this.statusMessage,
    this.sampleType,
    this.labProcess,
    this.result,
    this.noteResult,
    this.testTypeId,
    this.testTypeText,
    this.sampleFile,
  });

  factory MedicalHistoryData.fromMap(Map<String, dynamic> data) =>
      MedicalHistoryData(
        barcodeValue: data['barcode_value'] as int?,
        sampleId: data['sample_id'] as String?,
        identityNumber: data['identity_number'] as String?,
        transactionId: data['transaction_id'] as String?,
        status: data['status'] as int?,
        statusText: data['status_text'] as String?,
        statusMessage: data['status_message'] as String?,
        sampleType: data['sample_type'] as String?,
        labProcess: data['lab_process'] as String?,
        result: data['result'] as String?,
        noteResult: data['note_result'] as String?,
        testTypeId: data['test_type_id'] as int?,
        testTypeText: data['test_type_text'] as String?,
        sampleFile: data['sample_file'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'barcode_value': barcodeValue,
        'sample_id': sampleId,
        'identity_number': identityNumber,
        'transaction_id': transactionId,
        'status': status,
        'status_text': statusText,
        'status_message': statusMessage,
        'sample_type': sampleType,
        'lab_process': labProcess,
        'result': result,
        'note_result': noteResult,
        'test_type_id': testTypeId,
        'test_type_text': testTypeText,
        'sample_file': sampleFile,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MedicalHistoryData].
  factory MedicalHistoryData.fromJson(String data) {
    return MedicalHistoryData.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MedicalHistoryData] to a JSON string.
  String toJson() => json.encode(toMap());

  MedicalHistoryData copyWith({
    int? barcodeValue,
    String? sampleId,
    String? identityNumber,
    String? transactionId,
    int? status,
    String? statusText,
    String? statusMessage,
    String? sampleType,
    String? labProcess,
    String? result,
    String? noteResult,
    int? testTypeId,
    String? testTypeText,
    String? sampleFile,
  }) {
    return MedicalHistoryData(
      barcodeValue: barcodeValue ?? this.barcodeValue,
      sampleId: sampleId ?? this.sampleId,
      identityNumber: identityNumber ?? this.identityNumber,
      transactionId: transactionId ?? this.transactionId,
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      statusMessage: statusMessage ?? this.statusMessage,
      sampleType: sampleType ?? this.sampleType,
      labProcess: labProcess ?? this.labProcess,
      result: result ?? this.result,
      noteResult: noteResult ?? this.noteResult,
      testTypeId: testTypeId ?? this.testTypeId,
      testTypeText: testTypeText ?? this.testTypeText,
      sampleFile: sampleFile ?? this.sampleFile,
    );
  }

  @override
  List<Object?> get props {
    return [
      barcodeValue,
      sampleId,
      identityNumber,
      transactionId,
      status,
      statusText,
      statusMessage,
      sampleType,
      labProcess,
      result,
      noteResult,
      testTypeId,
      testTypeText,
      sampleFile,
    ];
  }
}
