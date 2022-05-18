import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:kayabe_lims/app/data/repository/article_repository.dart';

final articlesProvider =
    FutureProvider.autoDispose.family<List<ArticleModel>, String>(
  (ref, query) async {
    final repo = ref.watch(articleRepo);
    final result = await repo.getArticles(query);
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

final articleRepo = Provider.autoDispose<ArticleRepository>(
  (ref) => ArticleRepository(),
);
