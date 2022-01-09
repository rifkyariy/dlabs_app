class NationalityModel {
  final String id;
  final String value;

  NationalityModel({required this.id, required this.value});

  factory NationalityModel.fromJson(Map<String, dynamic> json) {
    return NationalityModel(
      id: json["id"],
      value: json["nationality"],
    );
  }

  static List<NationalityModel>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => NationalityModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String nationalityAsString() {
    return '#${this.id} ${this.value}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(NationalityModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => value;
}
