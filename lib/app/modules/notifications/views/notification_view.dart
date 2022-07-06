import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/models/notification_model.dart';
import 'package:kayabe_lims/app/data/repository/notification_repository.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:kayabe_lims/app/modules/notifications/controller/notification_controller.dart';

const _female =
    "https://media.discordapp.net/attachments/931941268760703117/991682442912092270/female-icon.png";
const _male =
    "https://media.discordapp.net/attachments/931941268760703117/991682443306336387/male-icon.png";

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
        title: Text("notification".tr),
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
                return Divider(
                  height: 1,
                  thickness: 1,
                  color: lightGreyColor,
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
    final DashboardController _dashboardController = Get.find();
    final format = DateFormat(DateFormat.HOUR_MINUTE);

    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    DateTime formattedDate =
        dateFormat.parse(notification.created_date.toString());
    String notifDate =
        "${formattedDate.hour.toString().padLeft(2, '0')}:${formattedDate.minute.toString().padLeft(2, '0')}";

    return ListTile(
      onTap: () async {
        EasyLoading.show();
        final client = ref.read(notifRepo);

        final response = await client.updateReadStatus(
            notificationId: int.parse(notification.id));
        EasyLoading.dismiss();

        ref.refresh(
          notificationsProvider,
        );

        client.getNotifications().then(
            (value) => _dashboardController.notifCount.value = value.length);
      },
      tileColor: notification.is_read == '1' ? whiteColor : softPrimaryColor,
      title: Text(
        notification.notification_text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(notifDate),
      leading: CircleAvatar(
        radius: 16,
        child: ClipOval(
          child: Image.network(
            image,
            errorBuilder: (context, error, stackTrace) {
              return Text(
                notification.created_by.split('').first.capitalize ?? '',
              );
            },
          ),
        ),
      ),
    );
  }
}
