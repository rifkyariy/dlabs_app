import 'package:google_sign_in/google_sign_in.dart';
import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
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
    gender.value = user.gender ?? '0';

    var googleKey = await _storage.readString('googleKey');
    if (await _storage.readString('googleKey') != "") {
      photoUrl.value = await _storage.readString('googlePhotoUrl') ?? '';
      fullname.value = await _storage.readString('googleFullName') ?? '';
    } else {
      fullname.value = user.full_name ?? '';
      photoUrl.value = user.image ?? '';
    }

    isLoggedIn.value = await _storage.readBool('isLoggedIn') ?? false;
    apiToken.value = _apiToken ?? '';

    print("auth status : $isLoggedIn , $apiToken");
    super.onInit();
  }

  void authCheck() {}

  void handleLogout() async {
    // Clear Local Rx Value
    fullname.value = '';
    gender.value = '';
    photoUrl.value = '';
    isLoggedIn.value = false;
    apiToken.value = '';

    // Logout Google
    final googlesigin = GoogleSignIn();
    googlesigin.signOut();

    // Remove Shared Preference
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('googleKey');
    sp.remove('apiToken');
    sp.remove('googleFullName');
    sp.remove('googlePhotoUrl');
    sp.remove('credentials');

    // Redirect into sign in pages
    Get.toNamed(AppPages.signin);
  }
}
