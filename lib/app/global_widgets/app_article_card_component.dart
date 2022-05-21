import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/modules/article/views/article_detail_view.dart';

class AppArticleCardComponent extends StatelessWidget {
  const AppArticleCardComponent({
    Key? key,
    required this.about,
    required this.title,
    required this.timestamp,
    required this.photoUrl,
    required this.id,
  }) : super(key: key);
  final String about, title, timestamp, photoUrl;
  final int id;
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    DateTime formattedDate = dateFormat.parse(timestamp);
    String articleDate =
        "${formattedDate.year.toString()}-${formattedDate.month.toString().padLeft(2, '0')}-${formattedDate.day.toString().padLeft(2, '0')} ${formattedDate.hour.toString().padLeft(2, '0')}:${formattedDate.minute.toString().padLeft(2, '0')}";

    return Card(
      child: InkWell(
        onTap: () {
          Get.to(() => ArticleDetailView(id: id));
        },
        child: SizedBox(
          height: SizeScalling().setHeight(120),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: photoUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: SizeScalling().setWidth(110),
                  height: SizeScalling().setHeight(120),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageProvider,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  width: SizeScalling().setWidth(110),
                  height: SizeScalling().setHeight(120),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://cdn.discordapp.com/attachments/900022715321311259/911572726915944468/unknown.png'),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: SizeScalling().setWidth(110),
                  height: SizeScalling().setHeight(120),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://cdn.discordapp.com/attachments/900022715321311259/911572726915944468/unknown.png'),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(17, 11, 35, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(
                          7,
                          2,
                          7,
                          2,
                        ),
                        margin: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        height: 15,
                        width: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: primaryColor,
                        ),
                        child: Text(
                          about,
                          style: appBannerButtonTextStyle,
                        ),
                      ),
                      Text(
                        title,
                        style: appTextStyleLatoFs14Fw500,
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.schedule,
                            color: greyColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            articleDate,
                            style: smallTextStyle(greyColor),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
