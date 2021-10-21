part of 'slide_banner_bloc.dart';

@immutable
abstract class SlideBannerState {}

class SlideBannerInitial extends SlideBannerState {}

class SlideBannerSuccess extends SlideBannerState {
  final List<SlideBannerEntity> slideBannerEntity;

  SlideBannerSuccess({required this.slideBannerEntity});
}

class SlideBannerError extends SlideBannerState {
  final String message;

  SlideBannerError({required this.message});
}

class SlideBannerLoading extends SlideBannerState {}

class SlideBannerOnClick extends SlideBannerState {
  final String message;

  SlideBannerOnClick({required this.message});
}
