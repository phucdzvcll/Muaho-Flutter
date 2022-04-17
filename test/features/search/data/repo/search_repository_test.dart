import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/features/search/data/repo/search_repository.dart';
import 'package:muaho/features/search/data/response/hot_search/hot_search_response.dart';
import 'package:muaho/features/search/data/services/search_service.dart';
import 'package:muaho/features/search/domain/use_case/get_list_hot_search_use_case.dart';

import '../../../../demo_mock/MockSearchService.dart';

class MockSearchService extends Mock implements SearchService {}

void main() {
  group('getListHotSearch', () {
    group("serviceRequestSuccess", () {
      test("emptyKeyWordAndEmptyShop", () async {
        //given
        SearchServiceImpl searchService = SearchServiceImpl();
        searchService.hotSearchResponse = Future.value(HotSearchResponse());
        SearchRepositoryImpl testObject =
            SearchRepositoryImpl(searchService: searchService);

        //when
        Either<Failure, HostSearchResult> result =
            await testObject.getListHotSearch();

        //then
        expect(searchService.countCallGetHotSearch, 1);
        expect(result.isSuccess, true);
        expect(result.success,
            HostSearchResult(listHotKeywords: [], listHotShop: []));
      });
      test("emptyShop", () async {
        //given
        MockSearchService searchService = MockSearchService();
        when(() => searchService.getHotSearch())
            .thenAnswer((_) => Future.value(HotSearchResponse()));
        SearchRepositoryImpl testObject =
            SearchRepositoryImpl(searchService: searchService);

        //when
        Either<Failure, HostSearchResult> result =
            await testObject.getListHotSearch();
        //then
        verify(() => searchService.getHotSearch()).called(1);
        expect(result.isSuccess, true);
        expect(result.success,
            HostSearchResult(listHotKeywords: [], listHotShop: []));
      });
      test("emptyKeyWord", () {
        print("getListHotSearch data /n");
      });
      test("haveData", () {
        print("getListHotSearch data /n");
      });
    });
    test("serviceRequestFail", () {
      print("getListHotSearch data /n");
    });
  });
}
