import 'dart:developer';

import 'package:get/get.dart';
import 'package:kayabe_lims/app/data/repository/article_repository.dart';

class ArticleController extends GetxController {
  ArticleController();

  final ArticleRepository _articleRepository = Get.find();

  @override
  void onInit() {
    // final data = await _articleRepository.getArticles("");
    // log(data.toString());
    super.onInit();
  }

  @override
  void onReady() {
    print("ATATATAT");
    super.onReady();
  }
}
