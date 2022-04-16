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

@freezed
class ArticleDetailModel with _$ArticleDetailModel {
  const factory ArticleDetailModel({
    required int id,
    required String image,
    required String title,
    required String status,
    required DateTime created_date,
    required String desc,
    required String meta_desc,
    required String meta_title,
    required int created_by,
    required int category_id,
    required String category_name,
    int? comment_count,
  }) = _ArticleDetailModel;

  factory ArticleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailModelFromJson(json);
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
  final ArticleData data;

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}

@JsonSerializable()
class ArticleData {
  ArticleData({
    required this.rows,
  });

  List<Map<String, dynamic>> rows;

  factory ArticleData.fromJson(Map<String, dynamic> json) =>
      _$ArticleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDataToJson(this);
}
