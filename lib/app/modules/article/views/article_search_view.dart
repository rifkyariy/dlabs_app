import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleSearchView extends ConsumerStatefulWidget {
  const ArticleSearchView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleSearchViewState();
}

class _ArticleSearchViewState extends ConsumerState<ArticleSearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST"),
      ),
    );
  }
}
