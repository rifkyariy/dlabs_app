class PatientModel {
  String identityNumber;
  String fullName;
  String email;
  String phoneNumber;
  String dateOfBirth;
  String gender;
  String address;
  String testType;
  double testPrice;

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
