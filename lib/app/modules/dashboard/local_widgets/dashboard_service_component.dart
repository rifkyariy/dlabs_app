import 'package:dlabs_apps/app/core/utils/size_scalling.dart';
import 'package:dlabs_apps/app/modules/dashboard/local_widgets/dashboard_service_card_component.dart';
import 'package:flutter/material.dart';

class DashboardServiceComponent extends StatelessWidget {
  const DashboardServiceComponent({
    Key? key,
    required this.serviceData,
  }) : super(key: key);
  final List serviceData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeScalling().setHeight(115),
      child: ListView.separated(
        itemCount: serviceData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return DashboardServiceCardComponent(
            title: serviceData[index].title,
            price: serviceData[index].price,
            subtitle: serviceData[index].subtitle,
          );
        },
        separatorBuilder: (context, item) {
          return SizedBox(width: SizeScalling().setWidth(15));
        },
      ),
    );
  }
}
