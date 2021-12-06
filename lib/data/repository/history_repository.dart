import 'package:muaho/data/data.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/main.dart';

class HistoryRepositoryImpl implements HistoryPageRepository {
  HistoryService service = getIt.get();

  @override
  Future<Either<Failure, List<OrderHistoryComplete>>>
      getOrderHistoryComplete() {
    // TODO: implement getOrderHistoryComplete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OrderHistoryDelivering>>>
      getOrderHistoryDelivering() async {
    var result = new List<OrderHistoryDelivering>.generate(
        10,
        (i) => OrderHistoryDelivering(
            orderId: i + 1,
            orderCode: "Code ${i + 1}",
            shopName: "shopName ${i + 1}",
            itemCount: 10 + i + 1,
            total: 2500.0 * (i + 1),
            status: i / 2 == 0 ? "Accepted" : "Tracking",
            thumbUrl: "https://picsum.photos/600/280?id=${i + 1}"));

    return SuccessValue(result);
  }
}
