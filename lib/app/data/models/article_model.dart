import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required int id,
    required String image,
    required String title,
    required String status,
    required DateTime created_date,
    required int created_by,
    required int category_id,
    required String category_name,
    int? comment_count,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}

@JsonSerializable()
class ArticleResponse {
  ArticleResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final Map<String, dynamic> data;

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}
