import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';

part 'search_shop_event.dart';
part 'search_shop_state.dart';

class SearchShopBloc extends Bloc<SearchShopEvent, SearchShopState> {
  final GetListShopBySearchUseCase getListShopBySearchUseCase;

  SearchShopBloc({required this.getListShopBySearchUseCase})
      : super(SearchShopInitial()) {
    on<SearchEvent>((event, emit) async {
      await _handleSearchEvent(event, emit);
    });
  }

  Future _handleSearchEvent(SearchEvent event, Emitter<SearchShopState> emit) async {
    emit(SearchShopLoading());
    Either<Failure, List<SearchShop>> result =
    await getListShopBySearchUseCase
        .execute(GetListShopBySearchParam(keyword: event.keyword));
    if (result.isSuccess) {
      emit(SearchShopSuccess(shops: result.success));
    } else {
      emit(SearchShopError());
    }
  }
}
