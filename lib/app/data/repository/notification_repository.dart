import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayabe_lims/app/core/utils/utils.dart';
import 'package:kayabe_lims/app/data/models/notification_model.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

final notifRepoProvider = Provider((ref) => NotificationRepository());

class NotificationRepository {
  final String _baseUrl = "https://api-dl.konsultasi.in/v1/web";

  // TODO create notification model
  Future<List<NotificationModel>> getNotifications() async {
    final storage = AppStorageService()..init();
    final token = await storage.readString('apiToken');

    final url = Uri.parse('$_baseUrl/notification/list');
    try {
      final NotificationResponse _response = await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/notification',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          {
            "page": 1,
            "max_rows": 6,
            "order_by": "id",
            "order_type": "asc",
            "search": [
              {"value": ""}
            ]
          },
        ),
      )
          .then((value) {
        logger.e(value.body);
        return NotificationResponse.fromJson(jsonDecode(value.body));
      });

      // TODO change to notification model

      switch (_response.status) {
        case "200":
          return _response.data.rows
              .map((e) => NotificationModel.fromJson(e))
              .toList();

        case "401":
          throw Exception('Authentication Failed');

        default:
          throw Exception('$_response.message');
      }
    } catch (e) {
      logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<bool> updateReadStatus({
    required int notificationId,
  }) async {
    final storage = AppStorageService()..init();
    final token = await storage.readString('apiToken');

    final url = Uri.parse('$_baseUrl/notification/update-read/$notificationId');
    try {
      final _response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/notification',
          'Authorization': 'Bearer $token',
        },
      );

      switch (_response.statusCode) {
        case 200:
          return true;

        case 401:
          return false;

        default:
          logger.e(_response.body);
          return false;
      }
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}
