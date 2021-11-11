part of 'slide_banner_bloc.dart';

@immutable
abstract class SlideBannerEvent {}

class RequestListBannerEvent extends SlideBannerEvent {}

class OnClickEvent extends SlideBannerEvent {
  final SlideBannerEntity banner;

  OnClickEvent({required this.banner});
}
