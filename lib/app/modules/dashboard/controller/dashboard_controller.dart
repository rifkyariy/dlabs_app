import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final AppStorageService _storage = Get.find();
  final AuthRepository _auth = Get.find();

  late RxString fullname = ''.obs;
  late RxString gender = ''.obs;
  late RxString photoUrl = ''.obs;
  late RxBool isLoggedIn = false.obs;
  late RxString apiToken = ''.obs;

  @override
  void onInit() async {
    final _apiToken = await _storage.readString('apiToken');

    final user = await _auth.getUserData(token: _apiToken ?? '');

    fullname.value = user.full_name ?? '';
    gender.value = user.gender ?? '0';
    photoUrl.value = user.image ?? '';

    isLoggedIn.value = await _storage.readBool('isLoggedIn') ?? false;
    apiToken.value = _apiToken ?? '';

    print("auth status : $isLoggedIn , $apiToken");
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
