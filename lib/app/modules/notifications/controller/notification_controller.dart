import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayabe_lims/app/data/models/notification_model.dart';
import 'package:kayabe_lims/app/data/repository/notification_repository.dart';

final notificationsProvider =
    FutureProvider.autoDispose<List<NotificationModel>>((ref) async {
  final client = ref.watch(notifRepoProvider);

  final response = await client.getNotifications();

  return response;
});

final notificationControllerProvider = StateNotifierProvider(
  (ref) => NotificationController(ref.read),
);

class NotificationController extends StateNotifier<bool> {
  NotificationController(this.read) : super(false);

  final Reader read;

  Future<bool> updateReadStatus({
    required int notificationId,
  }) async {
    final client = read(notifRepoProvider);

    final response = await client.updateReadStatus(
      notificationId: notificationId,
    );

    return response;
  }
}

final notifRepo = Provider.autoDispose<NotificationRepository>(
  (ref) => NotificationRepository(),
);
