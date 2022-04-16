import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:kayabe_lims/app/global_widgets/custom_network_image.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';

class ArticleDetailView extends StatefulWidget {
  const ArticleDetailView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ArticleDetailView> createState() => _ArticleDetailViewState();
}

class _ArticleDetailViewState extends State<ArticleDetailView> {
  final ArticleController c = Get.find();

  late ArticleDetailModel _article;

  @override
  void initState() {
    updateArticle();
    super.initState();
  }

  Future updateArticle() async {
    _article = await c.getArticleDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Articles"),
            flexibleSpace: FlexibleSpaceBar(
              background: CustomNetworkImage(""),
            ),
          ),
          const SliverToBoxAdapter(),
        ],
      ),
    );
  }
}
