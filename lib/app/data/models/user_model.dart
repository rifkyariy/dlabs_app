class UserModel {
  late int? id;
  late String? email;
  late String? full_name;
  late String? identity_number;
  late String? phone;
  late String? birth_date;
  late String? gender;
  late String? address;
  late String? image;
  late String? token;
  late String? nationality;
  dynamic status;
  String? errors;

  UserModel({
    this.id,
    this.email,
    this.full_name,
    this.identity_number,
    this.phone,
    this.birth_date,
    this.gender,
    this.address,
    this.image,
    this.token,
    this.status,
    this.nationality,
    this.errors,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    full_name = json['full_name'];
    identity_number = json['identity_number'];
    phone = json['phone'];
    birth_date = json['birth_date'];
    gender = json['gender'];
    address = json['address'];
    token = json['token'];
    nationality = json['nationality'];
    image = json.containsKey('image') ? json['image'] : "";
    status = json['status'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': full_name,
      'identity_number': identity_number,
      'phone': phone,
      'birth_date': birth_date,
      'gender': gender,
      'address': address,
      'image': image,
      'token': token,
      'nationality': nationality,
      'status': status,
      'errors': errors,
    };
  }
}
