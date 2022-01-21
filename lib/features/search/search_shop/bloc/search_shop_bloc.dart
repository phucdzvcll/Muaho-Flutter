import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/search/domain/models/search_shop/seach_shop_by_keyword.dart';
import 'package:muaho/features/search/domain/models/search_shop/search_shop_by_category.dart';
import 'package:muaho/features/search/domain/use_case/search_by_category_use_case.dart';
import 'package:muaho/features/search/domain/use_case/search_by_keyword_use_case.dart';

part 'search_shop_event.dart';
part 'search_shop_state.dart';

class SearchShopBloc extends Bloc<SearchShopEvent, SearchShopState> {
  final SearchShopByKeywordUseCase getListShopBySearchUseCase;
  final SearchShopByCategoryUseCase getListShopByCategoryUseCase;

  SearchShopBloc({
    required this.getListShopBySearchUseCase,
    required this.getListShopByCategoryUseCase,
  }) : super(SearchShopInitial()) {
    on<SearchByKeywordEvent>((event, emit) async {
      await _handleSearchEvent(event, emit);
    });

    on<SearchByCategoryEvent>((event, emit) async {
      await _handleSearchCategoryEvent(event, emit);
    });
  }

  Future _handleSearchCategoryEvent(
      SearchByCategoryEvent event, Emitter<SearchShopState> emit) async {
    emit(SearchShopLoading());
    Either<Failure, SearchShopByCategoryEntity> result =
        await getListShopByCategoryUseCase
            .execute(SearchShopByCategoryParam(categoryID: event.categoryID));
    if (result.isSuccess) {
      emit(SearchShopByCategorySuccess(result.success.shops,
          id: result.success.categoryId, category: result.success.category));
    } else {
      emit(SearchShopError());
    }
  }

  Future _handleSearchEvent(
      SearchByKeywordEvent event, Emitter<SearchShopState> emit) async {
    emit(SearchShopLoading());
    Either<Failure, List<SearchShopByKeywordEntity>> result =
        await getListShopBySearchUseCase
            .execute(GetListShopBySearchParam(keyword: event.keyword));
    if (result.isSuccess) {
      emit(SearchShopByKeywordSuccess(result.success));
    } else {
      emit(SearchShopError());
    }
  }
}
