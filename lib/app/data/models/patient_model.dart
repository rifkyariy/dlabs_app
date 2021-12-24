// List<PatientModel> locationFromJson(String str) => List<LocationModel>.from(
//     json.decode(str).map((x) => LocationModel.fromJson(x)));

class PatientModel {
  late int? id;
  late String identityNumber;
  late String nationality;
  late String fullName;
  late String email;
  late String phoneNumber;
  late String dateOfBirth;
  late String gender;
  late String address;
  late String testType;
  late String testTypeId;
  late double testPrice;

  PatientModel({
    this.id,
    required this.identityNumber,
    required this.nationality,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    this.gender = '1',
    required this.address,
    required this.testTypeId,
    required this.testType,
    required this.testPrice,
  });

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identityNumber = json['identity_number'];
    email = json['email'];
    fullName = json['name'];
    phoneNumber = json['phone'];
    dateOfBirth = json['date_of_birth'];
    // gender = json['gender']; tidak ada di json
    gender = '0'; // TODO jan lupa diganti kalau dah ada response barunya
    address = json['address'];
    testTypeId = json['test_type'];
    testPrice = json['price'].toDouble();
    testType = json['test_type_text'];
  }
}
