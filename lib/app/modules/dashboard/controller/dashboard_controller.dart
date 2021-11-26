import 'package:dlabs_apps/app/data/models/user_model.dart';
import 'package:dlabs_apps/app/data/repository/auth_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final AuthRepository _auth = Get.put(AuthRepository());

  late RxString? fullname = "".obs;
  late RxString? gender = "".obs;

  Future<UserModel> getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? '';

      print(token);

      UserModel userData = await _auth.getUserData(token: token);

      return userData;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getUserData().then((result) {
      print(result.full_name.split(" "));
      fullname!.value = result.full_name.split(" ").elementAt(0);
      gender!.value = result.gender;
    });
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

  void setState(Null Function() param0) {}
}

class _Service {
  final String title, price, subtitle;

  _Service(this.title, this.price, this.subtitle);
}

class _Article {
  final String about, title, timestamp, photoUrl;

  _Article(this.about, this.title, this.timestamp, this.photoUrl);
}
