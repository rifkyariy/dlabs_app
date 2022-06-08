import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/utils.dart';
import 'package:kayabe_lims/app/global_widgets/app_article_card_component.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';
import 'package:kayabe_lims/app/modules/article/views/article_search_view.dart';

class ArticleSearchView extends ConsumerStatefulWidget {
  const ArticleSearchView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleSearchViewState();
}

final categoryIdProvider = StateProvider((ref) => 0);
final searchKeyProvider = StateProvider((ref) => "");

final FocusNode searchFocusNode = FocusNode();

class _ArticleSearchViewState extends ConsumerState<ArticleSearchView> {
  @override
  Widget build(BuildContext context) {
    final categoryId = ref.watch(categoryIdProvider.state).state;
    final searchData = ref.watch(searchKeyProvider.state).state;

    TextEditingController searchController = TextEditingController();

    final categories = ref.watch(articleCategoriesProvider);
    // final articles = ref.watch(
    //     articlesProvider(ArticleFilter(searchController.text, categoryId)));
    final articles =
        ref.watch(articlesProvider(ArticleFilter(searchData, categoryId)));

    final latestArticles =
        ref.watch(articlesProvider(const ArticleFilter('', 0)));

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 32,
          alignment: Alignment.centerLeft,

          // App bar text field component
          // This appear when isSearchMode == ture
          child: TextField(
            controller: searchController,
            focusNode: searchFocusNode,

            // Textfield Decoration
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 1,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEBF0FF),
                  width: 0.5,
                ),
              ),
              suffixIcon: IconButton(
                //...
                // Clear Button is here
                onPressed: () {
                  // Clear the textfield controller.
                  searchController.clear();
                  ref.read(searchKeyProvider.notifier).state = "";
                  // Call onSearch Method to refresh the list.
                  // searchController.text = "";
                },
                icon: Icon(
                  Icons.cancel,
                  size: 16,
                  color: greyColor,
                ),
              ),
              contentPadding: const EdgeInsets.only(
                bottom: 16,
                left: 10,
              ),
            ),
            onSubmitted: (value) {
              ref.read(searchKeyProvider.notifier).state = value;
            },
            onChanged: (value) {},
            // On changed responsible to call search method on controller.
            // Will call everytime there change in textfield
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(searchKeyProvider.notifier).state =
                  searchController.text;
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

                        if (categoryId ==
                            ref.read(categoryIdProvider.notifier).state) {
                          ref.read(categoryIdProvider.notifier).state = 0;
                        } else {
                          ref.read(categoryIdProvider.notifier).state =
                              categoryId;
                        }
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
                return Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 10),
                        child: const Image(
                          image: AssetImage('assets/image/empty-article.png'),
                        ),
                      ),
                      Text(
                        'empty_article_title'.tr,
                        style: subtitleTextStyle(greyColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'empty_article_subtitle'.tr,
                        style: appServiceSubtitleTextStyle,
                      ),
                    ],
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
