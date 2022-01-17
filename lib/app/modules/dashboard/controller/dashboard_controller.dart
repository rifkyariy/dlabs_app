import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final AppStorageService _storage = Get.find();
  final AuthRepository _auth = Get.find();
  final AuthController _authController = Get.find();

  @override
  void onInit() async {
    // SharedPreferences sp = await SharedPreferences.getInstance();

    // final _apiToken = await _storage.readString('apiToken');

    // final user = await _auth.getUserData(token: _apiToken ?? '');
    // _authController.gender.value = user.gender ?? '0';

    // var googleKey = await _storage.readString('googleKey');
    // if (await _storage.readString('googleKey') != "") {
    //   _authController.photoUrl.value =
    //       await _storage.readString('googlePhotoUrl') ?? '';
    //   _authController.fullname.value =
    //       await _storage.readString('googleFullName') ?? '';
    // } else {
    //   _authController.fullname.value = user.full_name ?? '';
    //   _authController.photoUrl.value = user.image ?? '';
    // }

    // _authController.isLoggedIn.value =
    //     await _storage.readBool('isLoggedIn') ?? false;
    // _authController.apiToken.value = _apiToken ?? '';

    // print(
    //     "auth status : ${_authController.isLoggedIn} , ${_authController.apiToken}");
    super.onInit();
  }

  final dummyServiceData = <_Service>[
    _Service(
      "Swab Antigen",
      "750.000",
      "Also known as rapid antigen, works by detecting certain proteins from the virus that trigger an immune response.",
    ),
    _Service(
      "Swab Antigen 1",
      "750.000",
      "Also known as rapid antigen, works by detecting certain proteins from the virus that trigger an immune response.",
    ),
    _Service(
      "Swab Antigen 2",
      "750.000",
      "Also known as rapid antigen, works by detecting certain proteins from the virus that trigger an immune response.",
    ),
    _Service(
      "Swab Antigen 3",
      "750.000",
      "Also known as rapid antigen, works by detecting certain proteins from the virus that trigger an immune response.",
    ),
  ];

  final dummyArticleData = <_Article>[
    _Article(
      "Covid 19",
      "Yogyakarta Community Preparation for Vaccines",
      "23/10/2021, 12:34 WIB",
      "https://cdn.discordapp.com/attachments/900022715321311259/911559458314919946/unknown.png",
    ),
    _Article(
      "Covid 19",
      "Obesity ups medical spending for long-term cancer survivor",
      "23/10/2021, 12:34 WIB",
      "https://cdn.discordapp.com/attachments/900022715321311259/911572726915944468/unknown.png",
    ),
  ];
}

class _Service {
  final String title, price, subtitle;

  _Service(this.title, this.price, this.subtitle);
}

class _Article {
  final String about, title, timestamp, photoUrl;

  _Article(this.about, this.title, this.timestamp, this.photoUrl);
}
