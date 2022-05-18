import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';

class ImageUtils {
  static Future<XFile?> pickImageFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  static Future<File?> cropSelectedImage(String filePath) async {
    return await ImageCropper().cropImage(
      sourcePath: filePath,
      // aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop Image',
        aspectRatioLockEnabled: true,
        minimumAspectRatio: 1.0,
        aspectRatioPickerButtonHidden: true,
      ),
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: primaryColor,
        toolbarWidgetColor: whiteColor,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
    );
  }
}
