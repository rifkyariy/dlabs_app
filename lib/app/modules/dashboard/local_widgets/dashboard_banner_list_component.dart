import 'package:get/get.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_banner_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_service_card_component.dart';
import 'package:flutter/material.dart';

import 'dashboard_banner_card_component.dart';

class DashboardBannerListComponent extends StatelessWidget {
  const DashboardBannerListComponent({
    Key? key,
    required this.bannerList,
  }) : super(key: key);
  final List bannerList;

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);
    return SizedBox(
      height: SizeScalling().setHeight(150),
      width: double.infinity,
      child: ListView.separated(
        itemCount: bannerList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DashboardBannerCardComponent(onPressed: () {});
          } else {
            return DashboardServiceCardComponent(
              title: bannerList[index].title,
              price: bannerList[index].desc,
              subtitle: bannerList[index].redirectType,
            );
          }
        },
        separatorBuilder: (context, item) {
          return SizedBox(width: SizeScalling().setWidth(15));
        },
      ),
    );
  }
}
