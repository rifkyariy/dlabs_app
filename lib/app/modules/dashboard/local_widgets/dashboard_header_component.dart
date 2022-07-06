import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/modules/notifications/views/notification_view.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardHeaderComponent extends StatelessWidget {
  const DashboardHeaderComponent({
    Key? key,
    this.name,
    this.gender,
    this.photoUrl,
    this.notificationExist,
    this.notificationCount,
  }) : super(key: key);

  final String? name, photoUrl, gender;
  final bool? notificationExist;
  final int? notificationCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: notificationExist == true
                  ? CircleAvatar(
                      radius: SizeScalling().setRadius(22.5),
                      backgroundImage: NetworkImage(
                        photoUrl!.isNotEmpty
                            ? photoUrl!
                            : (gender == "0"
                                ? 'https://media.discordapp.net/attachments/931941268760703117/991682442912092270/female-icon.png'
                                : 'https://media.discordapp.net/attachments/931941268760703117/991682443306336387/male-icon.png'),
                      ),
                    )
                  : null),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello $name !', style: appAvatarNameTextStyle),
                SizedBox(height: SizeScalling().setHeight(5)),
                Text('gen_greeting'.tr, style: appAvatarSubtitleTextStyle),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.to(const NotificationView());
            },
            child: SizedBox(
              child: notificationExist == true
                  ? notificationCount != 0
                      ? Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Icon(
                              Icons.notifications_none_outlined,
                              color: primaryColor,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.red,
                                width: 12,
                                height: 12,
                                child: Center(
                                  child: Text(
                                    "$notificationCount",
                                    style: appNotificationNumberTextStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Icon(
                              Icons.notifications_none_outlined,
                              color: primaryColor,
                            ),
                          ],
                        )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
