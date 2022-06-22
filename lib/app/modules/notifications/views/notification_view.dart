import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:kayabe_lims/app/data/models/notification_model.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/notifications/controller/notification_controller.dart';

const _female =
    "https://cdn.discordapp.com/attachments/900022715321311259/913815656770711633/app-profile-picture-female.png";
const _male =
    "https://cdn.discordapp.com/attachments/900022715321311259/911343059827064832/app-profile-picture.png";

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notification".tr),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: notifications.when(
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const Text("Error Loading Notification"),
          data: (data) {
            final imageUrl = _authController.photoUrl.value != ""
                ? _authController.photoUrl.value
                : _authController.gender.value == "0"
                    ? _female
                    : _male;

            return ListView.separated(
              itemBuilder: (context, index) {
                final notif = data[index];
                return NotificationTiles(
                  image: imageUrl,
                  notification: notif,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                );
              },
              itemCount: data.length,
            );
          },
        ),
      ),
    );
  }
}

// Notification Tile Custom Widget

class NotificationTiles extends ConsumerWidget {
  const NotificationTiles({
    required this.notification,
    required this.image,
    Key? key,
  }) : super(key: key);

  final NotificationModel notification;
  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final format = DateFormat(DateFormat.HOUR_MINUTE);

    return ListTile(
      title: Text(
        notification.notification_text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(format.format(notification.created_date)),
      leading: CircleAvatar(
        radius: 16,
        child: Image.network(
          image,
          errorBuilder: (context, error, stackTrace) {
            return Text(
              notification.created_by.split('').first.capitalize ?? '',
            );
          },
        ),
      ),
    );
  }
}
