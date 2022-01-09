import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppEmptyStatePlaceholder extends StatelessWidget {
  const AppEmptyStatePlaceholder({
    Key? key,
    this.maximumSize = const Size(200, 200),
    this.minimumSize = const Size(50, 50),
    this.medical = false,
    required this.messages,
  }) : super(key: key);

  final Size maximumSize;
  final Size minimumSize;
  final bool medical;
  final String messages;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maximumSize.height,
          maxWidth: maximumSize.width,
          minHeight: minimumSize.height,
          minWidth: minimumSize.width,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            medical
                ? Image.asset('assets/image/app-empty-medic.png')
                : Image.asset('assets/image/app-empty-general.png'),
            const SizedBox(height: 10),
            Text('Empty', style: mediumTextStyle(greyColor, fontSize: 13)),
            const SizedBox(height: 10),
            Text(messages, style: regularTextStyle(greyColor, fontSize: 10))
          ],
        ),
      ),
    );
  }
}
