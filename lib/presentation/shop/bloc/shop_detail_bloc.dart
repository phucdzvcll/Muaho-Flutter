import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/shop/get_shop_product_use_case.dart';

part 'shop_detail_event.dart';
part 'shop_detail_state.dart';

class ShopDetailBloc extends Bloc<ShopDetailEvent, ShopDetailState> {
  GetShopProductUseCase _useCase = GetIt.instance.get();

  ShopDetailBloc() : super(ShopDetailInitial());

  @override
  Stream<ShopDetailState> mapEventToState(ShopDetailEvent event) async* {
    if (event is GetShopDetailEvent) {
      yield* _handleRequestEvent(event);
    }
  }

  Stream<ShopDetailState> _handleRequestEvent(GetShopDetailEvent event) async* {
    Either<Failure, ShopProductEntity> result =
        await _useCase.execute(ShopProductParam(shopID: event.shopID));
    yield ShopDetailLoading();
    if (result.isSuccess) {
      yield ShopDetailSuccess(shopProductEntity: result.success);
    } else {
      yield ShopDetailError();
    }
  }
}
