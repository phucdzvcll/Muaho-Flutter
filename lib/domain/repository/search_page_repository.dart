import 'package:muaho/domain/use_case/search/get_list_hot_search_use_case.dart';

import '../domain.dart';

abstract class SearchPageRepository {
  Future<Either<Failure, HostSearchResult>> getListHotSearch();
}
