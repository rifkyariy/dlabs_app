import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/custom_network_image.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';

class ArticleDetailView extends ConsumerStatefulWidget {
  const ArticleDetailView({required this.id, Key? key}) : super(key: key);
  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleDetailViewState();
}

class _ArticleDetailViewState extends ConsumerState<ArticleDetailView> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(articleDetailProvider(widget.id));
    final comments = ref.watch(articleCommentProvider(widget.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, stackTrace) => const Center(
          child: Text("Error loading data"),
        ),
        data: (article) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
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
                        Html(data: article.desc),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 40),
                      Divider(
                        height: 1,
                        color: greyColor,
                      ),
                      const SizedBox(height: 25),
                      comments.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, stackTrace) =>
                            const Center(child: Text("Error loading data")),
                        data: (comments) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Comment",
                                      style: GoogleFonts.lato(
                                        color: blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      " (${comments.length})",
                                      style: GoogleFonts.lato(
                                        color: greyColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                    hintText: "Add public comment",
                                    hintStyle: GoogleFonts.lato(
                                      color: const Color(0xFF323F4B),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        end: 20,
                                      ),
                                      child: CircleAvatar(
                                        radius: 10,
                                        child: Text("A"),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        EasyLoading.show();
                                        final result = await ref
                                            .read(articleRepo)
                                            .cereateArticleComment(
                                              articleId: widget.id,
                                              comment: commentController.text,
                                            );
                                        EasyLoading.dismiss();
                                        if (result) {
                                          EasyLoading.dismiss();
                                          EasyLoading.showSuccess(
                                            "Comment Published",
                                          );
                                          commentController.clear();
                                          ref.refresh(
                                            articleCommentProvider(widget.id),
                                          );
                                        } else {
                                          EasyLoading.dismiss();
                                          EasyLoading.showError(
                                            "Error Publishing Comment",
                                          );
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: Color(0xFF1176BC),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: greyColor,
                                ),
                                const SizedBox(height: 20),
                                for (final c in comments) ...[
                                  ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                      vertical: 0,
                                    ),
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 13,
                                          child: Text(c.name
                                                  .split('')
                                                  .first
                                                  .capitalize ??
                                              ''),
                                        )
                                      ],
                                    ),
                                    title: Text(
                                      c.name.capitalize ?? '',
                                      style: GoogleFonts.lato(
                                        color: blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${DateTime.now().difference(c.created_date).inDays} days ago",
                                          style: GoogleFonts.lato(
                                            color: greyColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(c.comment)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                                const SizedBox(height: 35),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
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
            height: 30,
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
