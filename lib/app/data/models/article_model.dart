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
    int? total_comments,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required int id,
    required String name,
    required int status,
    required DateTime created_date,
    required int created_by,
    required DateTime updated_date,
    required int updated_by,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
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
    required CategoryModel category,
    required CreatorModel created,
    int? total_comments,
  }) = _ArticleDetailModel;

  factory ArticleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailModelFromJson(json);
}

@freezed
class CreatorModel with _$CreatorModel {
  const factory CreatorModel({
    required int id,
    required String full_name,
    required String email,
    required String phone,
    required String birth_date,
    required String gender,
    required String address,
    required String nationality,
    String? image,
  }) = _CreatorModel;

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);
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
