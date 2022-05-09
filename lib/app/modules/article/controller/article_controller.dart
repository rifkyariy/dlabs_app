import 'dart:developer';

import 'package:get/get.dart';
import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:kayabe_lims/app/data/repository/article_repository.dart';

class ArticleController extends GetxController {
  ArticleController();

  final ArticleRepository _articleRepository = Get.find();
  late RxList<ArticleModel> articles = <ArticleModel>[].obs;

  Future<ArticleDetailModel> getArticleDetail(String id) async {
    final _data = await _articleRepository.getArticleDetail(id);

    return _data;
  }

  @override
  void onInit() async {
    final data = await _articleRepository.getArticles("");
    articles.value = data;

    super.onInit();
  }
}
