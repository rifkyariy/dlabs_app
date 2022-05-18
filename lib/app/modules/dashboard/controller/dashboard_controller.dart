import 'package:intl/intl.dart';
import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/repository/dashboard_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';

class DashboardController extends GetxController {
  final AppStorageService _storage = Get.find();
  final AuthRepository _auth = Get.find();
  final AuthController _authController = Get.find();
  final DashboardRepository _dashboardRepository = Get.find();

  final String baseUrl = "https://api-dl.konsultasi.in/";

  RxString apiToken = ''.obs;
  RxList<_Article> articleData = <_Article>[].obs;
  RxList<_Service> serviceData = <_Service>[].obs;
  RxList<_Banner> bannerData = <_Banner>[].obs;

  // Get List of Banner Data
  Future<void> fetchBannerData(token) async {
    bannerData.value =
        ((await _dashboardRepository.fetchBannerData(token: token))).map(
      (a) {
        String title = a['name'];
        String desc = a['desc'];
        String redirectType = a['redirect_type'];
        String redirectValue = a['value'];
        String timestamp = a['created_date'];
        String image = baseUrl + a['banner'];

        return _Banner(
            title, desc, timestamp, image, redirectType, redirectValue);
      },
    ).toList();

    bannerData.value.insert(0,
        _Banner('displayBanner', 'displayBanner', '', '', '/service/book', ''));
  }

  // Get List of Article Data
  Future<void> fetchArticleData(token) async {
    articleData.value =
        ((await _dashboardRepository.fetchArticleData(token: token))).map(
      (a) {
        String category = a['category_name'];
        String title = a['title'];
        String createdDate = a['created_date'];
        String image = baseUrl + a['image'];
        int id = a['id'];

        print(a);

        return _Article(category, title, createdDate, image, id);
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
    await fetchBannerData(_authController.apiToken.value);
    await fetchServiceData(_authController.apiToken.value);
    await fetchArticleData(_authController.apiToken.value);

    super.onInit();
  }
}

class _Service {
  final String title, price, subtitle;

  _Service(this.title, this.price, this.subtitle);
}

class _Article {
  final String about, title, timestamp, photoUrl;
  final int id;

  _Article(this.about, this.title, this.timestamp, this.photoUrl, this.id);
}

class _Banner {
  final String title, desc, timestamp, image, redirectType, redirectValue;

  _Banner(this.title, this.desc, this.timestamp, this.image, this.redirectType,
      this.redirectValue);
}
