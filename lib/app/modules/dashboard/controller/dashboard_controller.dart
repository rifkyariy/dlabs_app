import 'package:intl/intl.dart';
import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/repository/dashboard_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';

class DashboardController extends GetxController {
  final AppStorageService _storage = Get.find();
  final AuthRepository _auth = Get.find();
  final AuthController _authController = Get.find();
  final DashboardRepository _dashboardRepository = Get.find();

  final String baseUrl = "https://api-lims.kayabe.id/";

  late String? apiToken;
  late RxList<_Article> articleData = <_Article>[].obs;
  late RxList<_Service> serviceData = <_Service>[].obs;

  // Get List of Article Data
  Future<void> fetchArticleData(token) async {
    articleData.value =
        ((await _dashboardRepository.fetchArticleData(token: token))).map(
      (a) {
        String category = a['category_name'];
        String title = a['title'];
        String createdDate = a['created_date'];
        String image = baseUrl + a['image'];

        return _Article(category, title, createdDate, image);
      },
    ).toList();
  }

  // Get List of Service Data
  Future<void> fetchServiceData(token) async {
    serviceData.value =
        ((await _dashboardRepository.fetchServiceData(token: token))).map(
      (a) {
        var formatter = NumberFormat('###,000');

        String title = a['title'];
        String subtitle =
            'Also known as rapid antigen, works by detecting certain proteins from the virus that trigger an immune ' +
                a['sub_title'];
        String price = formatter.format(a['price']).toString();

        return _Service(title, price, subtitle);
      },
    ).toList();
  }

  @override
  void onInit() async {
    apiToken = await _storage.readString('apiToken');
    await fetchServiceData(apiToken);
    await fetchArticleData(apiToken);

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
      "Medical",
      "Yogyakarta Communities Preparation for Vaccines",
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
