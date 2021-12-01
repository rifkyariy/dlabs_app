class PatientModel {
  final String identityNumber;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String address;
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
