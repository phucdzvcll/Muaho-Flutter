import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/presentation/deeplink/model/deep_link_destination.dart';

part 'deeplink_handle_event.dart';
part 'deeplink_handle_state.dart';

class _DeepLinkEvent extends DeeplinkHandleEvent {
  final DeepLinkDestination deepLinkDestination;

  @override
  List<Object?> get props => [deepLinkDestination];

  const _DeepLinkEvent({
    required this.deepLinkDestination,
  });
}

class DeeplinkHandleBloc
    extends Bloc<DeeplinkHandleEvent, DeeplinkHandleState> {
  final AppLinks appLinks;

  DeeplinkHandleBloc({required this.appLinks})
      : super(DeeplinkHandleInitial()) {
    appLinks.onAppLink(
      onAppLink: (Uri uri, String stringUri) {
        _handleAppLinkUri(uri);
      },
    );
    on<_DeepLinkEvent>((event, emit) {
      emit(
        DeepLinkState(deepLinkDestination: event.deepLinkDestination),
      );
    });
    on<OpenInternalDeeplinkEvent>((event, emit) {
      Uri? uri = Uri.tryParse(event.deepLinkUrl);
      if (uri != null) {
        _handleAppLinkUri(uri);
      }
    });

    on<InitDeeplinkEvent>((event, emit) async {
      Uri? initDeepLinkUri = await appLinks.getInitialAppLink();
      if (initDeepLinkUri != null) {
        _handleAppLinkUri(initDeepLinkUri);
      }
    });
  }

  void _handleAppLinkUri(Uri uri) {
    var scheme = uri.scheme;
    var host = uri.host;
    if (scheme == "muaho" && host == "deeplink") {
      var path = uri.path;

      if (path == "/shop") {
        _handleShopDetailDeepLink(uri);
      } else if (path == "/search") {
        _handleSearchDeepLink(uri);
      } else if (path == "/orderDetail") {
        _handleOrderDetailDeepLink(uri);
      } else if (path == "/category") {
        _handleShopCategoryDeepLink(uri);
      }
    }
  }

  void _handleShopCategoryDeepLink(Uri uri) {
    String categoryId = uri.queryParameters["categoryId"] ?? "";
    int? categoryIdInt = int.tryParse(categoryId);
    if (categoryIdInt != null) {
      add(
        _DeepLinkEvent(
          deepLinkDestination:
              ShopCategoryDeepLinkDestination(shopCategory: categoryIdInt),
        ),
      );
    }
  }

  void _handleOrderDetailDeepLink(Uri uri) {
    String orderId = uri.queryParameters["orderId"] ?? "";
    int? orderIdInt = int.tryParse(orderId);
    if (orderIdInt != null) {
      add(
        _DeepLinkEvent(
          deepLinkDestination:
              OrderDetailDeepLinkDestination(orderId: orderIdInt),
        ),
      );
    }
  }

  void _handleSearchDeepLink(Uri uri) {
    String keyword = uri.queryParameters["keyword"] ?? "";
    if (keyword.isNotEmpty) {
      add(
        _DeepLinkEvent(
          deepLinkDestination: SearchDeepLinkDestination(keyword: keyword),
        ),
      );
    }
  }

  void _handleShopDetailDeepLink(Uri uri) {
    String id = uri.queryParameters["id"] ?? "";
    int? idInt = int.tryParse(id);
    if (idInt != null) {
      add(
        _DeepLinkEvent(
          deepLinkDestination: ShopDetailDeepLinkDestination(shopId: idInt),
        ),
      );
    }
  }
}
