part of 'deeplink_handle_bloc.dart';

abstract class DeeplinkHandleEvent extends Equatable {
  const DeeplinkHandleEvent();
}

class InitDeeplinkEvent extends DeeplinkHandleEvent {
  @override
  List<Object?> get props => [];
}

class OpenInternalDeeplinkEvent extends DeeplinkHandleEvent {
  final String deepLinkUrl;

  @override
  List<Object?> get props => [deepLinkUrl];

  const OpenInternalDeeplinkEvent({
    required this.deepLinkUrl,
  });
}
