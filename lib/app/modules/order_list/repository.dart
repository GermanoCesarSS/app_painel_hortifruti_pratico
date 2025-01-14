import 'package:app_painel_hortifruti_pratico/app/data/models/order.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class OrderListRepository {
  final Api _api;

  OrderListRepository(this._api);

  Future<List<OrderModel>> getOrders() => _api.getOrders();
}
