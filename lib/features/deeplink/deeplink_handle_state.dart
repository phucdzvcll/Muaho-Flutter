part of 'deeplink_handle_bloc.dart';

abstract class DeeplinkHandleState extends Equatable {
  const DeeplinkHandleState();
}

class DeeplinkHandleInitial extends DeeplinkHandleState {
  @override
  List<Object> get props => [];
}

class DeepLinkState extends DeeplinkHandleState {
  final DeepLinkDestination deepLinkDestination;
  final _deepLinkId = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object> get props => [deepLinkDestination, _deepLinkId];

  DeepLinkState({
    required this.deepLinkDestination,
  });
}
