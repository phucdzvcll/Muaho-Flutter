import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/search/domain/use_case/get_list_hot_search_use_case.dart';

part 'hot_search_event.dart';

part 'hot_search_state.dart';

class HotSearchBloc extends Bloc<HotSearchEvent, HotSearchState> {
  final GetHotSearchUseCase getHotSearchUseCase;

  HotSearchBloc({required this.getHotSearchUseCase})
      : super(HotSearchInitState()) {
    on<HotSearchRequestEvent>((event, emit) async {
      await _handleRequestHotSearch(event, emit);
    });
  }

  Future _handleRequestHotSearch(
    HotSearchRequestEvent event,
    Emitter<HotSearchState> emit,
  ) async {
    emit(HotSearchLoadingState());
    Either<Failure, HostSearchResult> result =
        await getHotSearchUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      emit(HotSearchSuccessState(result: result.success));
    } else {
      emit(HotSearchErrorState());
    }
  }
}
