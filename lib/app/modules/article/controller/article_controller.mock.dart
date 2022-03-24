import 'package:kayabe_lims/app/data/models/article_model.dart';

final List<ArticleModel> mockNewsData = List.generate(
  10,
  (i) => {
    "id": i,
    "image":
        "https://cdn.vox-cdn.com/thumbor/JrcQlUzU7UfPvMVPyHNp7nXoEXs=/0x0:5000x3333/1200x800/filters:focal(2100x1267:2900x2067)/cdn.vox-cdn.com/uploads/chorus_image/image/67119641/1227809769.jpg.0.jpg",
    "title": "Tips for choosing a good mask for health",
    "status": "publish",
    "created_date": "2022-02-13 17:52:57",
    "created_by": 1,
    "category_id": 1,
    "category_name": i % 2 == 0
        ? "Covid - 19"
        : i % 3 == 0
            ? "Health Tips"
            : "Life Style",
    "comment_count": 10
  },
).map((e) => ArticleModel.fromJson(e)).toList();

final Set<String> mockArticleCategory = List.generate(
  10,
  (i) => {
    "id": i,
    "image":
        "https://cdn.vox-cdn.com/thumbor/JrcQlUzU7UfPvMVPyHNp7nXoEXs=/0x0:5000x3333/1200x800/filters:focal(2100x1267:2900x2067)/cdn.vox-cdn.com/uploads/chorus_image/image/67119641/1227809769.jpg.0.jpg",
    "title": "Tips for choosing a good mask for health",
    "status": "publish",
    "created_date": "2022-02-13 17:52:57",
    "created_by": 1,
    "category_id": 1,
    "category_name": i % 2 == 0
        ? "Covid - 19"
        : i % 3 == 0
            ? "Health Tips"
            : i % 5 == 0
                ? "Hospital"
                : "Life Style",
    "comment_count": 10
  },
).map((e) => ArticleModel.fromJson(e).category_name).toSet();
