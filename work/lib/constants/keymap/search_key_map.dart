import 'package:flutter/material.dart';

class ActionUnit {
  static SearchAction searchAction = SearchAction();
}

class SearchIntent extends Intent {
  const SearchIntent();
}

class SearchAction extends Action<SearchIntent> {
  Function()? onSearch;

  @override
  Object? invoke(covariant SearchIntent intent) {
    print('-----SearchAction--------');
    if (onSearch != null) onSearch!();
    return null;
  }
}
