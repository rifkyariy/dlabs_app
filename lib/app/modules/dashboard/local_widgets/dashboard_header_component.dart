import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardHeaderComponent extends StatelessWidget {
  const DashboardHeaderComponent({
    Key? key,
    this.name,
    this.photoUrl,
    this.notificationExist,
    this.notificationCount,
  }) : super(key: key);

  final String? name, photoUrl;
  final bool? notificationExist;
  final int? notificationCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: SizeScalling().setRadius(22.5),
            backgroundImage: NetworkImage(photoUrl ??
                'https://cdn.discordapp.com/attachments/900022715321311259/911343059827064832/app-profile-picture.png'),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello, $name', style: appAvatarNameTextStyle),
                SizedBox(height: SizeScalling().setHeight(5)),
                Text('How are you today', style: appAvatarSubtitleTextStyle),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.snackbar(
                "Error",
                "No Route Specified",
                backgroundColor: dangerColor,
                snackPosition: SnackPosition.BOTTOM,
                animationDuration: const Duration(seconds: 1),
                duration: const Duration(seconds: 1),
                colorText: whiteColor,
              );
            },
            child: SizedBox(
              child: notificationExist ?? false
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
                  : Icon(Icons.notifications_none_outlined,
                      color: primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
