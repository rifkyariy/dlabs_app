import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppGoogleButton extends StatelessWidget {
  const AppGoogleButton({
    Key? key,
    this.onPressed,
    this.isLoading,
  }) : super(key: key);

  final void Function()? onPressed;
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: isLoading ?? false
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
              )
            : Image.asset(
                'assets/image/logo-google-48dp.png',
                width: 20.5,
                height: 20.5,
              ),
        label: Text(
          'Sign In with Google',
          style: subtitleTextStyle(blackColor),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: whiteColor,
          elevation: 0,
          minimumSize: const Size(double.infinity, 46),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              color: lightGreyColor,
            ),
            borderRadius: BorderRadius.circular(4.8),
          ),
        ),
      ),
    );
  }
}
