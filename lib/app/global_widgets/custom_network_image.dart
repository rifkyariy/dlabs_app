import 'package:flutter/material.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
    this.url, {
    Key? key,
    this.height,
    this.width,
    this.scale,
    this.fit,
  }) : super(key: key);

  final String url;
  final double? height;
  final double? width;
  final double? scale;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      fit: fit ?? BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        return loadingProgress == null
            ? child
            : Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
      },
      errorBuilder: (context, reason, stackTrace) {
        return Center(
          child: Text(
            "Error Loading Image",
            style: smallTextStyle(blackColor),
          ),
        );
      },
    );
  }
}
