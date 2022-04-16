import 'package:get/get.dart';
import 'package:kayabe_lims/app/data/repository/article_repository.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleController>(() => ArticleController());
    Get.lazyPut<ArticleRepository>(() => ArticleRepository());
  }
}
