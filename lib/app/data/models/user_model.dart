class UserModel {
  late int id;
  late String email;
  late String full_name;
  late String identity_number;
  late String phone;
  late String birth_date;
  late String gender;
  late String address;
  late String image;
  late String? token;

  UserModel({
    required this.id,
    required this.email,
    required this.full_name,
    required this.identity_number,
    required this.phone,
    required this.birth_date,
    required this.gender,
    required this.address,
    required this.image,
    required this.token,
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
    image = json.containsKey('image') ? json['image'] : "";
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
      'token': token
    };
  }
}
