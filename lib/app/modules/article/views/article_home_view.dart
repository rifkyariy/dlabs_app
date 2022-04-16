import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/app_article_card_component.dart';
import 'package:kayabe_lims/app/global_widgets/app_scaffold_with_navbar.dart';
import 'package:kayabe_lims/app/global_widgets/app_title_with_button.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.mock.dart';
import 'package:kayabe_lims/app/modules/article/widgets/news_card_square.dart';

class ArticleHomeView extends GetView<ArticleController> {
  ArticleHomeView({Key? key}) : super(key: key);

  final ArticleController c = Get.find();

  @override
  Widget build(BuildContext context) {
    final categories = mockArticleCategory;

    return AppScaffoldWithBottomNavBar(
      appBar: AppBar(
        title: const Text("Article"),
        automaticallyImplyLeading: false,
      ),
      visibleBottomNavBar: true,
      visibleFloatingActionButton: true,
      currentIndex: 3,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 23,
            horizontal: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppTitleWithButton(
                padding: EdgeInsets.zero,
                title: "Newest",
                buttonLabel: "View All",
                leadingSize: 18,
                trailingSize: 12,
              ),
              const SizedBox(height: 20),
              Obx(
                () => SizedBox(
                  height: 200,
                  child: ListView.separated(
                    itemCount: controller.articles.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsCardSquare(
                        article: controller.articles[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 20,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Text(
                        categories.elementAt(index),
                        style: BoldTextStyle(blackColor),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 50);
                  },
                ),
              ),
              const SizedBox(height: 30),
              Obx(() {
                final _articles = controller.articles;

                return Column(
                  children: [
                    for (final a in _articles) ...[
                      AppArticleCardComponent(
                        about: a.category_name,
                        title: a.title,
                        photoUrl: 'https://api-dl.konsultasi.in/${a.image}',
                        timestamp: a.created_date.toString(),
                        id: '${a.id}',
                      ),
                    ],
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
