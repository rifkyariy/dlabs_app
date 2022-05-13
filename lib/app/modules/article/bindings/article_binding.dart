import 'package:get/get.dart';
import 'package:kayabe_lims/app/data/repository/article_repository.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleRepository>(() => ArticleRepository());
  }
}
