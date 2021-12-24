import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/common/use_case.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/search/get_list_hot_search_use_case.dart';

part 'hot_search_event.dart';
part 'hot_search_state.dart';

class HotSearchBloc extends Bloc<HotSearchEvent, HotSearchState> {
  final GetHotSearchUseCase getHotSearchUseCase;

  HotSearchBloc({required this.getHotSearchUseCase})
      : super(HotSearchInitState());

  @override
  Stream<HotSearchState> mapEventToState(HotSearchEvent event) async* {
    if (event is HotSearchRequestEvent) {
      yield* _handleRequestHotSearch();
    }
  }

  Stream<HotSearchState> _handleRequestHotSearch() async* {
    yield HotSearchLoadingState();
    Either<Failure, HostSearchResult> result =
        await getHotSearchUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      yield HotSearchSuccessState(result: result.success);
    } else {
      yield HotSearchErrorState(mess: "error");
    }
  }
}
