import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/utils.dart';
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

  @override
  void initState() {
    super.initState();
  }

  Future updateArticle() async {
    return await c.getArticleDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: updateArticle(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            final article = snapshot.data as ArticleDetailModel;
            logger.i(article);
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: ImageSliverHeader(
                    url: 'https://api-dl.konsultasi.in/${article.image}',
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          article.title,
                          style: BoldTextStyle(blackColor, fontSize: 22),
                        ),
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          title: Text(article.created.full_name),
                          subtitle: Text(
                            DateFormat.yMMMMd().format(article.created_date),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              article.category.name,
                              style: smallTextStyle(
                                whiteColor,
                              ),
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Image.network(
                              article.created.image ?? '',
                              errorBuilder: (context, error, stackTrace) {
                                return Text(
                                  article.created.full_name
                                          .split('')
                                          .first
                                          .capitalize ??
                                      '',
                                );
                              },
                            ),
                          ),
                        ),

                        // Text(article.desc),
                        Html(data: article.desc),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text("Error load article"),
          );
        },
      ),
    );
  }
}

class ImageSliverHeader extends SliverPersistentHeaderDelegate {
  const ImageSliverHeader({required this.url});
  final String url;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomNetworkImage(url),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 15,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              color: Colors.grey[50],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
