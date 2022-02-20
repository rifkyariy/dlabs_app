import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/image_utils.dart';
import 'package:kayabe_lims/app/data/models/user_model.dart';
import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/repository/profile_repository.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';

class ProfileViewController extends GetxController {
  AuthController auth = Get.find();
  final AuthRepository _authRepo = Get.put(AuthRepository());
  final MasterDataRepository _masterData = Get.put(MasterDataRepository());

  late UserModel _userData;

  // Change Password Params
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxString oldPasswordErrorMessage = ''.obs;
  RxString newPasswordErrorMessage = ''.obs;
  RxString confirmPasswordErrorMessage = ''.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  RxBool imageLoadError = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;

  // Personal Information
  TextEditingController idNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController testLocationController = TextEditingController();
  TextEditingController testDateController = TextEditingController();
  RxString genderValue = '0'.obs;
  late TextEditingController selectedNationality;
  RxString selectedNationalityString = ''.obs;

  RxString identityNumberErrorMessage = ''.obs;
  RxString fullNameErrorMessage = ''.obs;
  RxString emailErrorMessage = ''.obs;
  RxString phoneNumberErrorMessage = ''.obs;
  RxString dateOfBirthErrorMessage = ''.obs;
  RxString addressErrorMessage = ''.obs;
  RxString testLocationErrorMessage = ''.obs;

  RxList<Map<String, dynamic>>? nationalityList = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> convertIntoList(
      List keyName, List<Map<String, dynamic>> data) {
    var defaultKey = ["id", "value"];

    for (var item in data) {
      for (var i = 0; i < keyName.length; i++) {
        if (item.containsKey(keyName[i])) {
          var value = item[keyName[i]];
          item[defaultKey[i]] = "$value";
        }
      }
    }

    return data;
  }

  // Get List of Nationality
  Future<List<Map<String, dynamic>>> getListofNationality() async {
    var result = await _masterData.getNationalityList();
    var apiServiceKey = ["id", "nationality"];

    return convertIntoList(apiServiceKey, result);
  }

  onSignOutButtonPressed() {
    auth.handleLogout();
  }

  onSignInButtonPressed() {
    Get.offNamed(AppPages.signin);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  handleUpdateProfile() async {
    try {
      isLoading.value = true;

      await ProfileRepository.updateProfileData(
        token: auth.apiToken.value,
        userId: '${_userData.id}',
        fullName: fullNameController.text,
        identityNumber: idNumberController.text,
        phone: phoneNumberController.text,
        birthDate: dateOfBirthController.text,
        gender: genderValue.value,
        address: addressController.text,
        nationality: selectedNationality.text,
      );

      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Your profile is updated!',
        backgroundColor: Colors.lightGreen,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Oops',
        'Something went wrong !',
        backgroundColor: warningColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  onUpdateProfilePicturePressed() async {
    // Step #1: Pick Image From Galler.
    await ImageUtils.pickImageFromGallery().then(
      (pickedFile) async {
        // Step #2: Check if we actually picked an image. Otherwise -> stop;
        if (pickedFile == null) return;

        // Step #3: Crop earlier selected image
        await ImageUtils.cropSelectedImage(pickedFile.path).then(
          (croppedFile) async {
            // Step #4: Check if we actually cropped an image. Otherwise -> stop;
            if (croppedFile == null) return;

            // Step #5: Display image on screen

            isLoading.value = true;

            await ProfileRepository.updateProfileData(
              path: croppedFile.path,
              token: auth.apiToken.value,
              userId: '${_userData.id}',
              fullName: _userData.full_name ?? '',
              identityNumber: _userData.identity_number ?? '',
              phone: _userData.phone ?? '',
              birthDate: _userData.birth_date ?? '',
              gender: _userData.gender ?? '',
              address: _userData.address ?? '',
              nationality: _userData.nationality ?? '',
            );

            // Update photoUrl
            _updatePhotoUrl();
            isLoading.value = false;
            Get.snackbar(
              'Success',
              'Your profile picture successfully changed.',
              backgroundColor: Colors.lightGreen,
              colorText: whiteColor,
              snackPosition: SnackPosition.TOP,
            );
          },
        );
      },
    );
  }

  _updatePhotoUrl() async {
    UserModel _model = await _authRepo.getUserData(token: auth.apiToken.value);

    auth.photoUrl.value = _model.image ?? '';
  }

  handleChangePassword() async {
    bool isPasswordValid =
        newPasswordController.text != '' && oldPasswordController.text != '';
    bool isPasswordLengthValid = newPasswordController.text.length >= 8;
    bool isConfirmPasswordValid = (confirmPasswordController.text != '' &&
            oldPasswordController.text != '') &&
        (newPasswordController.text == confirmPasswordController.text);

    if (isPasswordValid) {
      newPasswordErrorMessage.value = '';
      if (isPasswordLengthValid) {
        newPasswordErrorMessage.value = '';
        if (isConfirmPasswordValid) {
          newPasswordErrorMessage.value = '';
          isLoading.value = true;
          if (await _authRepo.changePassword(
              accessToken: _userData.token!,
              userId: _userData.id!.toString(),
              oldPassword: oldPasswordController.text,
              newPassword: newPasswordController.text)) {
            isLoading.value = false;
            oldPasswordErrorMessage.value = '';
            newPasswordErrorMessage.value = '';
            confirmPasswordErrorMessage.value = '';

            Get.snackbar(
              'Success',
              'Your password is changed.',
              backgroundColor: Colors.lightGreen,
              colorText: whiteColor,
              snackPosition: SnackPosition.TOP,
            );

            // remove password value
            oldPasswordController.text = '';
            newPasswordController.text = '';
            confirmPasswordController.text = '';
          } else {
            isLoading.value = false;

            Get.snackbar(
              'Oops',
              'Something went wrong !',
              backgroundColor: warningColor,
              colorText: whiteColor,
              snackPosition: SnackPosition.TOP,
            );

            oldPasswordErrorMessage.value = 'Old password is incorrect.';
          }
        } else {
          confirmPasswordErrorMessage.value =
              'Confirmation password doesn\'t match.';
        }
      } else {
        newPasswordErrorMessage.value =
            'Your password must be at least 8 characters.';
      }
    } else {
      if (oldPasswordController.text == '') {
        oldPasswordErrorMessage.value = 'Old password can\'t be blank.';
      }
      newPasswordErrorMessage.value = 'Your password can\'t be blank.';
    }
  }

  @override
  void onInit() async {
    _userData = await _authRepo.getUserData(token: auth.apiToken.value);

    await getListofNationality()
        .then((result) => nationalityList!.value = result.toList());

    isLoaded.value = true;
    fullNameController.text = _userData.full_name ?? '';
    emailController.text = _userData.email ?? '';
    idNumberController.text = _userData.identity_number ?? '';
    phoneNumberController.text = _userData.phone ?? '';
    dateOfBirthController.text = _userData.birth_date ?? '';
    addressController.text = _userData.address ?? '';
    genderValue.value = _userData.gender ?? '0';
    selectedNationality = TextEditingController(text: _userData.nationality);

    super.onInit();
  }
}
