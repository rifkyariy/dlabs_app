import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/utils.dart';
import 'package:kayabe_lims/app/global_widgets/app_article_card_component.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';
import 'package:kayabe_lims/app/modules/article/views/article_search_view.dart';

class ArticleAllView extends ConsumerStatefulWidget {
  const ArticleAllView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticleAllViewState();
}

final categoryIdProvider = StateProvider((ref) => 1);

class _ArticleAllViewState extends ConsumerState<ArticleAllView> {
  @override
  Widget build(BuildContext context) {
    final categoryId = ref.watch(categoryIdProvider.state).state;

    final categories = ref.watch(articleCategoriesProvider);
    final articles = ref.watch(articlesProvider(ArticleFilter('', categoryId)));
    final latestArticles =
        ref.watch(articlesProvider(const ArticleFilter('', 0)));

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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        children: [
          const SizedBox(
            height: 10,
          ),
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
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        int categoryId = categories.elementAt(index).id;
                        ref.read(categoryIdProvider.notifier).state =
                            categoryId;
                      },
                      child: Text(
                        categories.elementAt(index).name,
                        style: BoldTextStyle(categories.elementAt(index).id ==
                                ref.read(categoryIdProvider.notifier).state
                            ? primaryColor
                            : blackColor),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 30);
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          articles.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, stackTrace) => Center(
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: 'assets/image/app-book-banner.png',
                ),
              ),
            ),
            data: (articles) {
              if (articles.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 200),
                  child: const Image(
                    image: AssetImage('assets/image/empty-article.png'),
                  ),
                );
              } else {
                return Column(
                  children: [
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
              }
            },
          ),
        ],
      ),
    );
  }
}
