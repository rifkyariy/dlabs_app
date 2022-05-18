import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/utils.dart';
import 'package:kayabe_lims/app/global_widgets/app_article_card_component.dart';
import 'package:kayabe_lims/app/global_widgets/app_title_with_button.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';
import 'package:kayabe_lims/app/modules/article/views/article_search_view.dart';
import 'package:kayabe_lims/app/modules/article/widgets/news_card_square.dart';

class ArticleAllView extends ConsumerStatefulWidget {
  const ArticleAllView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticleAllViewState();
}

class _ArticleAllViewState extends ConsumerState<ArticleAllView> {
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(articleCategoriesProvider);
    final articles = ref.watch(articlesProvider(""));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Article"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const ArticleSearchView());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: articles.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, stackTrace) => const Center(
          child: Text("Error loading data"),
        ),
        data: (articles) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            children: [
              categories.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (e, stackTrace) {
                  logger.e(stackTrace);
                  return const Center(
                    child: Text("Error loading data"),
                  );
                },
                data: (categories) {
                  return SizedBox(
                    height: 20,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Text(
                            categories.elementAt(index).name,
                            style: BoldTextStyle(blackColor),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 50);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              for (final a in articles) ...[
                AppArticleCardComponent(
                  about: a.category_name,
                  title: a.title,
                  photoUrl: 'https://api-dl.konsultasi.in/${a.image}',
                  timestamp: a.created_date.toString(),
                  id: a.id,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
