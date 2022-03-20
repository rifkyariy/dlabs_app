import 'package:flutter/material.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:kayabe_lims/app/global_widgets/custom_network_image.dart';

class NewsCardSquare extends StatelessWidget {
  const NewsCardSquare({required this.article, Key? key}) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Ink(
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 250,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                CustomNetworkImage(
                  article.image,
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xFF161616).withOpacity(.8),
                        const Color(0x00000000),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  right: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          article.category_name,
                          textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: true,
                          ),
                          style: smallTextStyle(whiteColor),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article.title,
                        style: BoldTextStyle(
                          whiteColor,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.schedule,
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${DateTime.now().difference(article.created_date).inDays} Days ago",
                            style: smallTextStyle(whiteColor),
                            textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false,
                              applyHeightToLastDescent: true,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.sms_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${article.comment_count} comment",
                            style: smallTextStyle(whiteColor),
                            textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false,
                              applyHeightToLastDescent: true,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
