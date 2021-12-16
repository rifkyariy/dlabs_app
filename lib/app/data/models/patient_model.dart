class PatientModel {
  late final String identityNumber;
  late final String fullName;
  late final String email;
  late final String phoneNumber;
  late final String dateOfBirth;
  late final String gender;
  late final String address;
  final String testType;
  final double testPrice;

  PatientModel({
    required this.identityNumber,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.testType,
    required this.testPrice,
  });
}
