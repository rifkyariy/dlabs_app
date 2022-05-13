import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/app_article_card_component.dart';
import 'package:kayabe_lims/app/global_widgets/app_scaffold_with_navbar.dart';
import 'package:kayabe_lims/app/global_widgets/app_title_with_button.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.mock.dart';
import 'package:kayabe_lims/app/modules/article/widgets/news_card_square.dart';

class ArticleHomeView extends ConsumerStatefulWidget {
  const ArticleHomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleHomeViewState();
}

class _ArticleHomeViewState extends ConsumerState<ArticleHomeView> {
  @override
  Widget build(BuildContext context) {
    final categories = mockArticleCategory;

    final articles = ref.watch(articlesProvider(""));

    return AppScaffoldWithBottomNavBar(
      appBar: AppBar(
        title: const Text("Article"),
        automaticallyImplyLeading: false,
      ),
      visibleBottomNavBar: true,
      visibleFloatingActionButton: true,
      currentIndex: 3,
      body: articles.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, stackTrace) => const Center(
          child: Text("Error loading data"),
        ),
        data: (articles) {
          return SingleChildScrollView(
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
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      itemCount: articles.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsCardSquare(
                          article: articles[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 10);
                      },
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
                  Column(
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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
