import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';

part 'slide_banner_event.dart';
part 'slide_banner_state.dart';

class SlideBannerBloc extends Bloc<SlideBannerEvent, SlideBannerState> {
  final GetListBannerUseCase _bannerUseCase = GetIt.instance.get();

  SlideBannerBloc() : super(SlideBannerInitial());

  @override
  Stream<SlideBannerState> mapEventToState(SlideBannerEvent event) async* {
    if (event is RequestListBannerEvent) {
      yield* _handleRequestListBanner();
    }
    if (event is OnClickEvent) {
      yield SlideBannerOnClick(message: event.banner.subject);
    }
  }

  Stream<SlideBannerState> _handleRequestListBanner() async* {
    yield SlideBannerLoading();
    Either<Failure, BannersResult> result =
        await _bannerUseCase.execute(EmptyInput());
    if (result.isSuccess) {
      yield SlideBannerSuccess(slideBannerEntity: result.success.listBanner);
    } else {
      yield SlideBannerError(message: "message");
    }
  }
}
