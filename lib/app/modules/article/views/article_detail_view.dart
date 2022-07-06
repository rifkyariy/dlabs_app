import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/constants.dart';
import 'package:kayabe_lims/app/core/utils/utils.dart';
import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:kayabe_lims/app/global_widgets/custom_network_image.dart';
import 'package:kayabe_lims/app/modules/article/controller/article_controller.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';

class ArticleDetailView extends ConsumerStatefulWidget {
  const ArticleDetailView({required this.id, Key? key}) : super(key: key);
  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleDetailViewState();
}

class _ArticleDetailViewState extends ConsumerState<ArticleDetailView> {
  final commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(articleDetailProvider(widget.id));

    return Scaffold(
      appBar: AppBar(
        title: Text("articles".tr),
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
          commentTotal.value = article.total_comments!;
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPersistentHeader(
                  delegate: ImageSliverHeader(
                    url: 'https://api-dl.konsultasi.in/${article.image}',
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            DateFormat("EEEE, d MMMM yyyy",
                                    Get.deviceLocale.toString())
                                .format(article.created_date),
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
                      Padding(
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
                                Obx(
                                  () => Text(
                                    " (${commentTotal.value})",
                                    style: GoogleFonts.lato(
                                      color: greyColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            CommentInputField(
                              article: article,
                              controller: commentController,
                            ),
                            const SizedBox(height: 20),
                            CommentLists(
                              articleId: article.id,
                            ),
                            OnGoingBottomWidget(
                              articleId: article.id,
                            ),
                          ],
                        ),
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
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFFAFAFA),
              ),
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

class CommentInputField extends ConsumerWidget {
  CommentInputField({
    required this.controller,
    required this.article,
    Key? key,
  }) : super(key: key);

  final AuthController _authController = Get.find();
  final TextEditingController controller;
  final ArticleDetailModel article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: _authController.isLoggedIn.value
          ? Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Add public comment",
                    hintStyle: GoogleFonts.lato(
                      color: const Color(0xFF323F4B),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 20,
                      ),
                      child: CircleAvatar(
                        radius: 13,
                        child: ClipOval(
                          child: Image.network(
                            _authController.photoUrl.value != ""
                                ? _authController.photoUrl.value
                                : _authController.gender.value == "0"
                                    ? Constants.femalePic
                                    : Constants.malePic,
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
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        EasyLoading.show();
                        final result =
                            await ref.read(articleRepo).createArticleComment(
                                  articleId: article.id,
                                  comment: controller.text,
                                  fullname: _authController.fullname.value,
                                );

                        EasyLoading.dismiss();

                        if (result) {
                          EasyLoading.dismiss();
                          EasyLoading.showSuccess(
                            "Comment Published",
                          );

                          controller.clear();

                          ref.refresh(commentsProvider(article.id));

                          // // Refresh article data
                          // ref.refresh(
                          //   articlesProvider(const ArticleFilter('', 0)),
                          // );
                          commentTotal.value += 1;

                          EasyLoading.dismiss();
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
              ],
            )
          : AppButton(
              text: 'Login Untuk Memberi Komentar',
              textColor: whiteColor,
              onClicked: () {
                Get.toNamed(AppPages.signin);
              },
            ),
    );
  }
}

class CommentTile extends StatelessWidget {
  const CommentTile({
    required this.comment,
    Key? key,
  }) : super(key: key);

  final ArticleCommentModel comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          comment.name.isNotEmpty
              ? CircleAvatar(
                  radius: 13,
                  child: ClipOval(
                    child: Image.network(
                      "https://api-dl.konsultasi.in/" +
                          comment.created_by_photo,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          comment.name.split('').first.capitalize ?? "",
                        );
                      },
                    ),
                  ),
                )
              : const CircleAvatar(
                  radius: 13,
                  child: Text('-'),
                )
        ],
      ),
      title: Text(
        comment.name.capitalize ?? '',
        style: GoogleFonts.lato(
          color: blackColor,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateTime.now()
                .difference(comment.created_date)
                .inDays
                .convertDayFromToday,
            style: GoogleFonts.lato(
              color: greyColor,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Text(comment.comment)
        ],
      ),
    );
  }
}

class CommentLists extends ConsumerWidget {
  const CommentLists({
    required this.articleId,
    Key? key,
  }) : super(key: key);

  final int articleId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commentsProvider(articleId));

    return state.when(
      data: (data) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final x in data) ...[
            CommentTile(comment: x),
            const SizedBox(height: 10),
          ]
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Text("Error"),
      onGoingLoading: (data) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final x in data) ...[
            CommentTile(comment: x),
            const SizedBox(height: 10),
          ]
        ],
      ),
      onGoingError: (err, stack) => const Text("Error"),
    );
  }
}

// Start with 2, I try start with 1 but I got error, God knows why
final currentLoadedBatch = StateProvider.autoDispose((ref) => 2);

class OnGoingBottomWidget extends ConsumerWidget {
  const OnGoingBottomWidget({
    required this.articleId,
    Key? key,
  }) : super(key: key);
  final int articleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commentsProvider(articleId));
    final page = ref.watch(currentLoadedBatch);
    return state.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: (data) {
        final noMoreItems =
            ref.read(commentsProvider(articleId).notifier).noMoreItems;

        if (noMoreItems) {
          return Center(
            child: TextButton(
              onPressed: () {
                ref.read(commentsProvider(articleId).notifier).limitDataToMin();
              },
              child: Text(
                "article_unload_comment".tr,
                style: smallTextStyle(
                  greyColor,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: TextButton(
              onPressed: () {
                ref.read(currentLoadedBatch.notifier).state += 1;
                ref
                    .read(commentsProvider(articleId).notifier)
                    .fetchNextBatch(page);
              },
              child: Text(
                'article_load_comment'.tr,
                style: smallTextStyle(
                  greyColor,
                ),
              ),
            ),
          );
        }
      },
      onGoingLoading: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
      onGoingError: (_, __) => const Center(
        child: Text("Error"),
      ),
    );
  }
}
