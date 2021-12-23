import 'package:muaho/common/common.dart';
import 'package:muaho/data/data.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/main.dart';

class HistoryRepositoryImpl implements HistoryPageRepository {
  HistoryService service = getIt.get();

  @override
  Future<Either<Failure, List<OrderHistoryComplete>>>
      getOrderHistoryComplete() async {
    var request = service.getOrderHistoryComplete();
    var result = await handleNetworkResult(request);
    if (result.isSuccess()) {
      List<OrderHistoryComplete> list = [];
      result.response?.forEach((element) {
        list.add(OrderHistoryComplete(
            orderId: element.orderId.defaultZero(),
            orderCode: element.orderCode.defaultEmpty(),
            shopName: element.shopName.defaultEmpty(),
            itemCount: element.itemCount.defaultZero(),
            total: element.total.defaultZero(),
            status: element.status.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty()));
      });
      return SuccessValue(list);
    } else {
      return FailValue(Failure());
    }
  }

  @override
  Future<Either<Failure, List<OrderHistoryDelivering>>>
      getOrderHistoryDelivering() async {
    var request = service.getOrderHistoryDelivering();
    var result = await handleNetworkResult(request);

    if (result.isSuccess()) {
      List<OrderHistoryDelivering> list = [];
      result.response?.forEach((element) {
        list.add(OrderHistoryDelivering(
            orderId: element.orderId.defaultZero(),
            orderCode: element.orderCode.defaultEmpty(),
            shopName: element.shopName.defaultEmpty(),
            itemCount: element.itemCount.defaultZero(),
            total: element.total.defaultZero(),
            status: element.status.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty()));
      });
      return SuccessValue(list);
    } else {
      return FailValue(Failure());
    }
  }
}
