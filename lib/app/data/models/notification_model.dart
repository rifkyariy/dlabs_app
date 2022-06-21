import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationResponse {
  NotificationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final NotificationData data;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}

@JsonSerializable()
class NotificationData {
  NotificationData({
    required this.rows,
  });

  List<Map<String, dynamic>> rows;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

@JsonSerializable()
class NotificationModel {
  NotificationModel({
    required this.id,
    required this.notification_text,
    required this.user_id,
    required this.is_read,
    required this.transaction_id,
    required this.created_date,
    required this.created_by,
  });

  final String id;
  final String notification_text;
  final String user_id;
  final String is_read;
  final String transaction_id;
  final DateTime created_date;
  final String created_by;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
