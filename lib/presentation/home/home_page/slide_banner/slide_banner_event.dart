part of 'slide_banner_bloc.dart';

@immutable
abstract class SlideBannerEvent {}

class RequestListBannerEvent extends SlideBannerEvent {
  final String jwt;

  RequestListBannerEvent({required this.jwt});
}

class OnClickEvent extends SlideBannerEvent {
  final SlideBannerEntity banner;

  OnClickEvent({required this.banner});
}
