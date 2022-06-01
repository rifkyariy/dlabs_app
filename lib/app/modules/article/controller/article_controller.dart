import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:kayabe_lims/app/data/repository/article_repository.dart';

class ArticleFilter<String, int> extends Equatable {
  final String query;
  final int category;

  const ArticleFilter(this.query, this.category);

  @override
  List<Object?> get props => [query, category];
}

final articlesProvider = FutureProvider.autoDispose
    .family<List<ArticleModel>, ArticleFilter<String, int>>(
  (ref, filter) async {
    final repo = ref.watch(articleRepo);
    final result = await repo.getArticles(filter.query, filter.category);
    return result;
  },
);

final articleDetailProvider =
    FutureProvider.autoDispose.family<ArticleDetailModel, int>(
  (ref, id) async {
    final repo = ref.watch(articleRepo);
    final result = await repo.getArticleDetail(id);
    return result;
  },
);

final articleCommentProvider =
    FutureProvider.autoDispose.family<List<ArticleCommentModel>, int>(
  (ref, id) async {
    final repo = ref.watch(articleRepo);
    final result = await repo.getArticleComment(id);
    return result;
  },
);

final articleCategoriesProvider =
    FutureProvider.autoDispose<List<ArticleCategoryModel>>(
  (ref) async {
    final repo = ref.watch(articleRepo);
    final result = await repo.getArticleCategories();
    return result;
  },
);

final articleRepo = Provider.autoDispose<ArticleRepository>(
  (ref) => ArticleRepository(),
);
