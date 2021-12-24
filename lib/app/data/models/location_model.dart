// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationFromJson(String str) => List<LocationModel>.from(
    json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationToJson(List<LocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  LocationModel({
    this.locationName,
    this.locationAddress,
    this.latitude,
    this.longitude,
    this.status,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.label,
    this.id,
  });

  String? locationName;
  String? label;
  String? locationAddress;
  String? latitude;
  String? longitude;
  String? status;
  String? createdDate;
  String? createdBy;
  String? updatedDate;
  String? updatedBy;
  int? id;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        locationName: json["location_name"],
        locationAddress: json["location_address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        createdDate: json["created_date"],
        createdBy: json["created_by"],
        updatedDate: json["updated_date"],
        updatedBy: json["updated_by"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "location_name": locationName,
        "location_address": locationAddress,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "created_date": createdDate,
        "created_by": createdBy,
        "updated_date": updatedDate,
        "updated_by": updatedBy,
        "id": id,
      };
}
