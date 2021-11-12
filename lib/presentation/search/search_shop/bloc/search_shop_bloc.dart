import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';

part 'search_shop_event.dart';
part 'search_shop_state.dart';

class SearchShopBloc extends Bloc<SearchShopEvent, SearchShopState> {
  GetListShopBySearchUseCase _useCase = GetIt.instance.get();

  SearchShopBloc() : super(SearchShopInitial());

  @override
  Stream<SearchShopState> mapEventToState(SearchShopEvent event) async* {
    yield SearchShopLoading();
    if (event is SearchEvent) {
      Either<Failure, List<SearchShop>> result = await _useCase
          .execute(GetListShopBySearchParam(keyword: event.keyword));
      if (result.isSuccess) {
        yield SearchShopSuccess(shops: result.success);
      } else {
        yield SearchShopError();
      }
    }
  }
}
