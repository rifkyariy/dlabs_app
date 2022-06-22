import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kayabe_lims/app/core/utils/utils.dart';
import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:kayabe_lims/app/data/repository/article_repository.dart';

part 'article_controller.freezed.dart';

class ArticleFilter<String, int> extends Equatable {
  final String query;
  final int category;

  const ArticleFilter(this.query, this.category);

  @override
  List<Object?> get props => [query, category];
}

class CommentPagination extends Equatable {
  final int page, articleId;

  const CommentPagination(this.articleId, this.page);

  @override
  List<Object?> get props => [articleId, page];
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

final commentsProvider = StateNotifierProvider.autoDispose.family<
    PaginationNotifier<ArticleCommentModel>,
    PaginationState<ArticleCommentModel>,
    int>((ref, int articleId) {
  final repo = ref.watch(articleRepo);
  return PaginationNotifier(
    fetchNextItems: (page) {
      return repo.getArticleComment(articleId, page);
    },
    itemsPerBatch: 10,
  )..init();
});

class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  PaginationNotifier({
    required this.fetchNextItems,
    required this.itemsPerBatch,
  }) : super(const PaginationState.loading());

  final Future<List<T>> Function(int item) fetchNextItems;
  final int itemsPerBatch;

  final List<T> _items = [];

  void init() {
    if (_items.isEmpty) {
      fetchFirstBatch();
    }
  }

  bool noMoreItems = false;

  void updateData(List<T> result) {
    noMoreItems = result.isEmpty;

    if (result.isEmpty) {
      state = PaginationState.data(_items);
    } else {
      state = PaginationState.data(_items..addAll(result));
    }
  }

  Future<void> fetchFirstBatch() async {
    try {
      state = const PaginationState.loading();

      // Fetch the first batch of the comments.
      // This will be called during initial states
      final List<T> result = await fetchNextItems(1);

      updateData(result);
    } catch (e, stack) {
      state = PaginationState.error(e, stack);
    }
  }

  Future<void> fetchNextBatch(int page) async {
    assert((page > 0), "Page can't be negative");

    logger.d("Fetching next batch of items");

    state = PaginationState.onGoingLoading(_items);

    try {
      // Just add delayed to prevent sudden update
      await Future.delayed(const Duration(seconds: 1));
      // Fetch first batch of comment
      final result = await fetchNextItems(page);

      logger.d(page);
      logger.d(result);
      updateData(result);
    } catch (e, stack) {
      state = PaginationState.onGoingError(e, stack);
    }
  }
}

@freezed
class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState.data(List<T> items) = _Data;
  const factory PaginationState.loading() = _Loading;
  const factory PaginationState.error(Object? e, [StackTrace? stackTrace]) =
      _Error;
  const factory PaginationState.onGoingLoading(List<T> items) = _OnGoingLoading;
  const factory PaginationState.onGoingError(Object? e,
      [StackTrace? stackTrace]) = _OnGoingError;
}
