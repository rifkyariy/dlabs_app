import 'package:dlabs_apps/app/core/utils/app_icons.dart';
import 'package:dlabs_apps/app/global_widgets/slideable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class BookingListTile extends StatelessWidget {
  const BookingListTile({
    Key? key,
    this.updateButtonPressed,
    this.deleteButtonPressed,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final Function(BuildContext)? updateButtonPressed;
  final Function(BuildContext)? deleteButtonPressed;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: key,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: updateButtonPressed,
              backgroundColor: const Color(0xFF1176BC),
              foregroundColor: Colors.white,
              icon: AppIcons.sync, // TODO update Icons
              label: 'Update',
            ),
            SlidableAction(
              onPressed: deleteButtonPressed,
              backgroundColor: const Color(0xFFDC3545),
              foregroundColor: Colors.white,
              icon: AppIcons.trash,
              label: 'Delete',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Column(
          children: [
            const Divider(height: 0),
            ListTile(
              leading: CircleAvatar(child: Text(title[0])),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            const Divider(height: 0),
          ],
        ));
  }
}